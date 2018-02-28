# intigral
terraform template

Pre-requisite

1- install awscli on your client PC

2- export AWS key/secret

3- export key:

export TF_VAR_raja_public_key_file=<PATH TO THE PUBLIC KEY>

export TF_VAR_raja_private_key_file=<PATH TO THE PRIVATE KEY>

4- replace variables in the variables.tf file 
  
Run terraform

1- terraform init (to initialize the plugins)

2- terraform plan

3- terraform apply
