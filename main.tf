# Create providers 

provider "aws" {
  region     = "eu-west-1"
  access_key = "Access-Key"
  secret_key = "Secret-Key"
}

provider "github" {
  token = "Secret-Token"
}

# Create resources 
resource "aws_instance" "omari-hmrc-vm" {
  ami           = "ami-01dd271720c1ba44f"
  instance_type = "t2.micro"
  network_interface {
    network_interface_id = aws_network_interface.omari-hmrc-ni_public.id
    device_index         = 0
  }
  tags = {
    Name = "omari-hmrc"
  }

}

resource "aws_vpc" "omari-hmrc-vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "omari-hmrc"
  }
}

resource "aws_subnet" "omari-hmrc-subnet_public" {
  vpc_id                  = aws_vpc.omari-hmrc-vpc.id
  cidr_block              = "10.0.128.0/18"
  map_public_ip_on_launch = true
  tags = {
    Name = "omari-hmrc"
  }
}

resource "aws_subnet" "omari-hmrc-subnet_private" {
  vpc_id     = aws_vpc.omari-hmrc-vpc.id
  cidr_block = "10.0.192.0/18"
  tags = {
    Name = "omari-hmrc"
  }
}

resource "aws_security_group" "omari-hmrc-sg" {
  name   = "omari-hmrc-sg"
  vpc_id = aws_vpc.omari-hmrc-vpc.id
  tags = {
    Name = "omari-hmrc"
  }
}

resource "aws_vpc_security_group_ingress_rule" "omari-hmrc-sg_ssh" {
  security_group_id = aws_security_group.omari-hmrc-sg.id

  cidr_ipv4   = "0.0.0.0/0"
  from_port   = 22
  ip_protocol = "tcp"
  to_port     = 22
  tags = {
    Name = "omari-hmrc"
  }
}
resource "aws_vpc_security_group_ingress_rule" "omari-hmrc-sg_80" {
  security_group_id = aws_security_group.omari-hmrc-sg.id

  cidr_ipv4   = "0.0.0.0/0"
  from_port   = 80
  ip_protocol = "tcp"
  to_port     = 80
  tags = {
    Name = "omari-hmrc"
  }
}
resource "aws_vpc_security_group_egress_rule" "omari-hmrc-sg_out" {
  security_group_id = aws_security_group.omari-hmrc-sg.id

  ip_protocol = -1
  cidr_ipv4   = "0.0.0.0/0"
  tags = {
    Name = "omari-hmrc"
  }
}

resource "aws_internet_gateway" "omari-hmrc-igw" {
  vpc_id = aws_vpc.omari-hmrc-vpc.id
  tags = {
    Name = "omari-hmrc"
  }

}

resource "aws_network_interface" "omari-hmrc-ni_public" {
  subnet_id       = aws_subnet.omari-hmrc-subnet_public.id
  security_groups = [aws_security_group.omari-hmrc-sg.id]
  tags = {
    Name = "omari-hmrc"
  }
}

resource "github_repository" "terraform_backend_repo" {
  name = "sparta_terraform_backend_repo1"
  description = "sparta_terraform_backend_repo"
  visibility = "public"
}