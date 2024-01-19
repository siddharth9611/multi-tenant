terraform {
  backend "remote" {
    organization = "siddharth9611"
    workspaces {
      name = "dev"
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
###
module "main_vpc" {
  source = "../../../../modules/vpc"
  name = "EKS_test"
  environment = "dev"
  vpc_cidr = "10.0.0.0/16"
  avail_zone = "ap-south-1a"
  pub_subnet_cidr = "10.0.101.0/24"
  prv_subnet_cidr = "10.0.1.0/24"
}