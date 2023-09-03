# TODO

[ ] Write readme file

## Steps to get link

```bash
terraform init 2>&1 > /dev/null
terraform apply -auto-approve > output.txt
egrep "http://.*/admin" output.txt | sed 's/.*\(http:\/\/.*\/admin\).*/\1/' > link.txt
cat link.txt
```