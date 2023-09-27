# Terraform upskill

- TF_VARS must be in lower case
- use seperate files for different providers and resources where necessary
- Use terraform init when adding new providers
- the terraform state file contains all resource information 
- can use tfvars to set variable values and over ride the default value
- can use env variables by prefixing TF_VARS followed by the lower case env variable
- initialise modules with terraform init 
- modules use variables from root .tfvars
- use must pass variables as a variable if the module in root
- variables must be declared at root and module level

![Diagram of prerequisutes and infrastruture](Terraform%20Upskill.drawio.png)

## Remote state

To initialise the S3 remote backend populate the following variables in a file s3.conf.

```
access_key = ""
secret_key = ""
bucket = ""
region = ""

```

Then run command

```
terraform init -backend-config="s3.conf"

```