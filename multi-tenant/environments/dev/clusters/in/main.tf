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
  source = "../../../../modules/vpc_v2"
}


#######--------------outputs-------------##############

output "vpc" {
  value = module.main_vpc
}


output "name" {
  value = local.name
}