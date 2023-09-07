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