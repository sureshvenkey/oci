## There env tfvars files
* ./dev/terraform.tfvars
* ./uat/terraform.tfvars
* ./prod/terraform.tfvars  
## Use below command to execute with tfvars
` terraform plan -var-file ./dev/terraform.tfvars`     
` terraform apply -var-file ./dev/terraform.tfvars `
