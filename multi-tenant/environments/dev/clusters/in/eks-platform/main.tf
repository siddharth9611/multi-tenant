terraform {
  backend "remote" {
    organization = "siddharth9611"
    workspaces {
      name = "dev-in-eks-platform"
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

##########--------data sources----------########

# data "terraform_remote_state" "dev" {
#   backend = "remote"
#   config = {
#     organization = "siddharth9611"
#     workspaces = {
#       name = "dev"
#     }
#   }
# }

data "terraform_remote_state" "dev-in" {
  backend = "remote"
  config = {
    organization = "siddharth9611"
    workspaces = {
      name = "dev-in"
    }
  }
}



###############-----------------eks-cluster--------------#############
 module "eks-in-cluster" {
  source = "../../../../../modules/eks-cluster"
  cluster_name = data.terraform_remote_state.dev-in.outputs.name
  cluster_subnet_id1 = data.terraform_remote_state.dev-in.outputs.vpc.pub_subnet
  cluster_subnet_id2 = data.terraform_remote_state.dev-in.outputs.vpc.prv_subnet
}