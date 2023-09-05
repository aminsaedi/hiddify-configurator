#!/bin/sh


terraform init 2>&1 > /dev/null
terraform apply -auto-approve 
FQDN=$(terraform output -raw direct-fqdn)

cd ./ansible
ansible-playbook playbooks/main.yml -e "fqdn=$FQDN" 

cat /tmp/link

# connect to server and run the following commands

# sqlite3 ./hiddify-panel/hiddifypanel.db "INSERT INTO domain (domain,mode,sub_link_only,child_id,cdn_ip,grpc,servernames) VALUES ('"$DIRECT_DOMAIN"', 'direct',0,0,'',0,'')"
# sqlite3 ./hiddify-panel/hiddifypanel.db "INSERT INTO domain (domain,mode,sub_link_only,child_id,cdn_ip,grpc,servernames) VALUES ('"$CLOUD_DOMAIN"', 'cdn',0,0,'',0,'')"
# sqlite3 ./hiddify-panel/hiddifypanel.db "INSERT INTO domain (domain,mode,sub_link_only,child_id,cdn_ip,grpc,servernames) VALUES ('"$CLOUD_AUTO_DOMAIN"', 'auto_cdn_ip',0,0,'',0,'')"
# /opt/hiddify-config/apply_configs.sh


# ssh -o StrictHostKeyChecking=accept-new root@$IP_ADDRESS << EOF
#     sqlite3 /opt/hiddify-config/hiddify-panel/hiddifypanel.db "INSERT INTO domain (domain,mode,sub_link_only,child_id,cdn_ip,grpc,servernames) VALUES ('"$DIRECT_DOMAIN"', 'direct',0,0,'',0,'')"
#     sqlite3 /opt/hiddify-config/hiddify-panel/hiddifypanel.db "INSERT INTO domain (domain,mode,sub_link_only,child_id,cdn_ip,grpc,servernames) VALUES ('"$CLOUD_DOMAIN"', 'cdn',0,0,'',0,'')"
#     sqlite3 /opt/hiddify-config/hiddify-panel/hiddifypanel.db "INSERT INTO domain (domain,mode,sub_link_only,child_id,cdn_ip,grpc,servernames) VALUES ('"$CLOUD_AUTO_DOMAIN"', 'auto_cdn_ip',0,0,'',0,'')"
#     /opt/hiddify-config/apply_configs.sh
# EOF
#
# cat link.txt | xargs xdg-open
