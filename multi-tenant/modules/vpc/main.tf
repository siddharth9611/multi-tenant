# variable "name" {}
# variable "vpc_cidr" {}
# variable "azs" {}
# variable "private_subnets_cidr" {}
# variable "public_subnets_cidr" {}
# variable "nat" {
#   default = true
#   type = bool
# }

# variable "vpn" {
#   default = false
#   type = bool
# }



# #### ----------------main-vpc----------------

# module "vpc" {
#   source = "terraform-aws-modules/vpc/aws"

#   name = var.name
#   cidr = var.vpc_cidr

#   azs             = var.azs
#   private_subnets = var.private_subnets_cidr
#   public_subnets  = var.public_subnets_cidr
#   enable_nat_gateway = var.nat
#   enable_vpn_gateway = var.vpn

#   tags = {
#     Environment = "dev"
#   }
# }

###_______________________variables_________________________########

variable avail_zone {}
variable "environment" {}
variable "name" {}
variable "vpc_cidr" {}
variable "pub_subnet_cidr" {}
variable "prv_subnet_cidr" {}

#############__________________LOCALS______________##############
locals {
  vpc_name = "${var.environment}_${var.name}_vpc"
}

##############_______________________VPC contents______________________################


resource "aws_vpc" "vpc"{
    cidr_block = var.vpc_cidr
    tags = {
        Name = local.vpc_name
        vpc_env = var.environment
    }
}

resource "aws_subnet" "pub_subnet" {
    vpc_id = aws_vpc.vpc.id
    cidr_block = var.pub_subnet_cidr
    availability_zone = var.avail_zone
    tags = {
      Name = "${local.vpc_name}_pub_subnet"
    }
}

resource "aws_subnet" "prv_subnet" {
    vpc_id = aws_vpc.vpc.id
    cidr_block = var.prv_subnet_cidr
    availability_zone = var.avail_zone
    tags = {
      Name = "${local.vpc_name}_prv_subnet"
    }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "${local.vpc_name}_igw"
    }
}

resource "aws_route_table" "pub_route_table" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "${local.vpc_name}_pub_rtable"
  }

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
    }
}

resource "aws_route_table" "prv_route_table" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "${local.vpc_name}_prv_rtable"
  }
}

resource "aws_route_table_association" "pub_rtable_association" {
    subnet_id = aws_subnet.pub_subnet.id
    route_table_id = aws_route_table.pub_route_table.id
}

resource "aws_route_table_association" "prv_rtable_association" {
  subnet_id = aws_subnet.prv_subnet.id
  route_table_id = aws_route_table.prv_route_table.id
}

resource "aws_security_group" "sg" {
    name = "${local.vpc_name}_sg"
    vpc_id = aws_vpc.vpc.id

    ingress {
        from_port = 0
        to_port = 0
        protocol = "all"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port = 8080
        to_port = 8080
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "all"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
      Name = "${local.vpc_name}_sg"
    }
}

###########___________________outputs___________________#######

output "pub_subnet" {
    value = aws_subnet.pub_subnet.id
}

output "prv_subnet" {
    value = aws_subnet.prv_subnet.id
}