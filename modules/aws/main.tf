# This file is for terraform IaC support-configuration


# who is the provider

# provider "aws" {
#   # in ireland 
#   region     = var.aws_region
#   access_key = var.sparta_aws_access
#   secret_key = var.sparta_aws_secret
# }

# create 2 env variable for access and secret
## SPARTA_AWS_ACCESS
## SPARTA_AWS_SECRET


# once completed reopen the vs code terminal as admin

# create a resource on aws - a vm/ec2

resource "aws_instance" "omari-hmrc-vm" {
  # which os to use - AMI-ID
  # ami = "ami-0cc99f74c9d01b7ed"
  # linux ubuntu 18.04 lts
  ami           = var.ec2_ami
  instance_type = var.ec2_type # the type of instance
#   associate_public_ip_address = true
  network_interface {
    network_interface_id = aws_network_interface.omari-hmrc-ni_public.id
    device_index         = 0
  }
#   network_interface {
#     network_interface_id = aws_network_interface.omari-hmrc-ni_private.id
#     device_index         = 1
#   }
 
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

# resource "aws_network_interface" "omari-hmrc-ni_private" {
#     subnet_id       = aws_subnet.omari-hmrc-subnet_private.id
#     security_groups = [aws_security_group.omari-hmrc-sg.id]
#   tags = {
#     Name = "omari-hmrc"
#   }

# }


resource "aws_network_interface" "omari-hmrc-ni_public" {
  subnet_id       = aws_subnet.omari-hmrc-subnet_public.id
  security_groups = [aws_security_group.omari-hmrc-sg.id]
  tags = {
    Name = "omari-hmrc"
  }
}
