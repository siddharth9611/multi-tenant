#========================================================================
#
#    Module      : uniphore_vpc
#
#========================================================================

#----------------------------- Variables -----------------------------

variable "region" {
  default     = "ap-south-1"
  description = "AWS region"
}
variable "name" {}
variable "availability_zones" {}
variable "cidr" {
  default = "10.0.0.0/16"
}
variable "private_subnets" {
  type    = list(string)
  default = ["10.0.32.0/19", "10.0.64.0/19", "10.0.96.0/19"]
}
variable "public_subnets" {
  default = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
}
variable "enable_nat_gateway" {
}

locals {
  vpc_tags = {
  }
  public_subnet_tags = merge(
    {
      "kubernetes.io/role/elb" = "1"
    }
  )
  private_subnet_tags = merge(
    {
      "kubernetes.io/role/internal-elb" = "1"
    }
  )
}

#----------------------------- Networking -----------------------------

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.16.0"

  name                           = var.name
  cidr                           = var.cidr
  azs                            = var.availability_zones
  private_subnets                = var.private_subnets
  public_subnets                 = var.public_subnets
  enable_nat_gateway             = var.enable_nat_gateway
  single_nat_gateway             = true
  one_nat_gateway_per_az         = false
  enable_flow_log                = false
  tags                           = local.vpc_tags
  public_subnet_tags             = local.public_subnet_tags
  private_subnet_tags            = local.private_subnet_tags

}

#----------------------------- Outputs -----------------------------

output "vpc" {
  value = module.vpc
}
