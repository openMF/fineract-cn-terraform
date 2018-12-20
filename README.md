# fineract-cn-terraform
Terraform scripts for Fineract CN AWS infrastructure.

Region, project, environment variables should be set correctly in poc/main.tf, poc/terraform.tfvars, poc-tfstate/terraform.tfvars files. Description of variables is in vars.tf file.

A public key should be added to environments/poc/ folder, that will be copied to the bastion instance to allow login.

Manual deployment is needed through the bastion instance.

## Usage
Generate an RSA key-pair, and add the public key to `environments/poc/` folder. That will be copied automatically to the instances to allow login. The other instances will be accessible through the bastion - private pair should be copied manually to the bastion.

Set the desired region, project, environment values for variables in the following files:
* `environments/poc/main.tf`
* `environments/poc/terraform.tfvars`
* `environments/poc-tfstate/terraform.tfvars`

Run the following commands:

`cd environments/poc-tfstate/`

`terraform init`

`terraform plan`

`terraform apply`


`cd environments/poc/`

`terraform init`

`terraform plan`

`terraform apply`


For removing the infrastructure:
`cd environments/poc/`
`terraform destroy`

`cd environments/poc-tfstate/`
`terraform destroy` - it might throw error. In that case remove the S3 bucket and DynamoDB table manually.

Error cases:
If `terraform init`, `terraform plan`, `terraform apply` commands do not run, but the infrastructure is destroyed, it might be necessary to manually clean up the environments folder. For this:
`cd environments/poc-tfstate/`
`rm terraform.tfstate`
`rm -r .terraform/`

`cd environments/poc/`
`rm terraform.tfstate`
`rm -r .terraform/`

Then retry terraform commands.
