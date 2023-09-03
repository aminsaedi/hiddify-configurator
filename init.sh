#!/bin/sh


REIGIONS_LIST=$(doctl compute region list | grep true | cut -f1 -d" ")

# ask user for region
echo "Please select a region:"
select REGION in $REIGIONS_LIST
do
    echo "You selected $REGION"
    break
done

sed -i '/region.*/d' terraform.tfvars 
echo -e '\nregion = "'$REGION'"' >> terraform.tfvars

terraform init 2>&1 > /dev/null
terraform apply -auto-approve -var-file="terraform.tfvars" 2>&1 | tee output.txt
egrep "https://.*sslip.*/admin" output.txt | sed 's/.*\(https:\/\/.*\/admin\).*/\1/' > link.txt
# cat link.txt | xargs xdg-open

IP_ADDRESS=$(terraform output -raw ipv4_address)

echo "Please enter your FQDN:"
read DOMAIN


DIRECT_DOMAIN="direct-$DOMAIN"
CLOUD_DOMAIN="cloud-$DOMAIN"
CLOUD_AUTO_DOMAIN="cloud-auto-$DOMAIN"

CLOUDFLARE_API_KEY=$(cat terraform.tfvars| grep cloudflare_api_key | grep -o '".*"' | sed 's/"//g')
CLOUDFLARE_ZONE_ID=$(cat terraform.tfvars| grep cloudflare_zone_id | grep -o '".*"' | sed 's/"//g')


if [ -z "$CLOUDFLARE_API_KEY" ]
then
      echo "Cloudflare API key not found in terraform.tfvars"
      exit 1
fi

if [ -z "$CLOUDFLARE_ZONE_ID" ]
then
      echo "Cloudflare Zone ID not found in terraform.tfvars"
      exit 1
fi

curl --request POST \
  --url https://api.cloudflare.com/client/v4/zones/$CLOUDFLARE_ZONE_ID/dns_records \
  --header 'Content-Type: application/json' \
  --header 'Authorization: Bearer '$CLOUDFLARE_API_KEY'' \
  --data '{
  "content": "'$IP_ADDRESS'",
  "name": "'$DIRECT_DOMAIN'",
  "proxied": false,
  "type": "A",
  "comment": "Added by Terraform Hiddify",
  "ttl": 1
}'

curl --request POST \
  --url https://api.cloudflare.com/client/v4/zones/$CLOUDFLARE_ZONE_ID/dns_records \
  --header 'Content-Type: application/json' \
  --header 'Authorization: Bearer '$CLOUDFLARE_API_KEY'' \
  --data '{
  "content": "'$IP_ADDRESS'",
  "name": "'$CLOUD_DOMAIN'",
  "proxied": true,
  "type": "A",
  "comment": "Added by Terraform Hiddify",
  "ttl": 1
}'

curl --request POST \
  --url https://api.cloudflare.com/client/v4/zones/$CLOUDFLARE_ZONE_ID/dns_records \
  --header 'Content-Type: application/json' \
  --header 'Authorization: Bearer '$CLOUDFLARE_API_KEY'' \
  --data '{
  "content": "'$IP_ADDRESS'",
  "name": "'$CLOUD_AUTO_DOMAIN'",
  "proxied": true,
  "type": "A",
  "comment": "Added by Terraform Hiddify",
  "ttl": 1
}'


# connect to server and run the following commands

# sqlite3 ./hiddify-panel/hiddifypanel.db "INSERT INTO domain (domain,mode,sub_link_only,child_id,cdn_ip,grpc,servernames) VALUES ('"$DIRECT_DOMAIN"', 'direct',0,0,'',0,'')"
# sqlite3 ./hiddify-panel/hiddifypanel.db "INSERT INTO domain (domain,mode,sub_link_only,child_id,cdn_ip,grpc,servernames) VALUES ('"$CLOUD_DOMAIN"', 'cdn',0,0,'',0,'')"
# sqlite3 ./hiddify-panel/hiddifypanel.db "INSERT INTO domain (domain,mode,sub_link_only,child_id,cdn_ip,grpc,servernames) VALUES ('"$CLOUD_AUTO_DOMAIN"', 'auto_cdn_ip',0,0,'',0,'')"
# /opt/hiddify-config/apply_configs.sh