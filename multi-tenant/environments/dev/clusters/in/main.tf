terraform {
  backend "cloud" {
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
  source             = "../../../../modules/vpc_V2"
  name               = "devops-practise"
  availability_zones = ["ap-south-1a", "ap-south-1c", "ap-south-1b"]
  enable_nat_gateway = true
}

#######--------------outputs-------------##############

output "vpc" {
  value = module.main_vpc
}


output "name" {
  value = local.name
}

