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
terraform apply -auto-approve -var-file="terraform.tfvars" 2>&1 > output.txt
egrep "https://.*sslip.*/admin" output.txt | sed 's/.*\(https:\/\/.*\/admin\).*/\1/' > link.txt
cat link.txt
