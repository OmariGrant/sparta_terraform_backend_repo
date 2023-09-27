provider "aws" {
  # in ireland 
  region     = var.aws_region
  access_key = var.sparta_aws_access
  secret_key = var.sparta_aws_secret
}

provider "github" {
  token = var.sparta_github_token
}

module "aws_module" {
    source = "./modules/aws"
    ec2_type = var.ec2_type
    ec2_ami = var.ec2_ami
}

module "github_module" { 
    source = "./modules/github"
}

terraform {
  backend "s3" {
  }
}