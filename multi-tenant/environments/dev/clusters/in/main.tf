terraform {
  backend cloud {
    organization = "siddharth9611"
    workspaces {
      name = "dev-in"
    }
  }

  required_providers {
    aws = {
        source = "hashicorp/aws"
    }
  }
}

provider "aws" {
    region = "ap-south-1"
}

locals {
  name = "multi-tenant-eks"
}
#######--------------------vpc-----------------################

module "main_vpc" {
  source = "../../../../modules/vpc"
  name = "${local.name}-vpc"
  environment = "dev"
  vpc_cidr = "10.0.0.0/16"
  avail_zone = "ap-south-1a"
  pub_subnet_cidr = "10.0.101.0/24"
  prv_subnet_cidr = "10.0.1.0/24"
}


#######--------------outputs-------------##############

output "vpc" {
  value = module.main_vpc
}


output "name" {
  value = local.name
}