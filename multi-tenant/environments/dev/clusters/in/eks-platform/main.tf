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
    kubernetes = {
      source = "hashicorp/kubernetes"
      version = "~> 2.35.1"
    }
  }
}

#########--------cluster-auth-data-----------##########
data "aws_eks_cluster" "cluster" {
  name = module.eks.cluster_id
}

data "aws_eks_cluster_auth" "cluster_auth" {
  name = module.eks.cluster_id
}

provider "kubernetes" {
  host = data.aws_eks_cluster.cluster.endpoint
  token = data.aws_eks_cluster_auth.cluster_auth.token
  cluster_ca_certificate = base64decode(data.aws_eks_cluster_auth.cluster_auth.certificate_authority.0.data)
}

provider "aws" {
    region = "ap-south-1"
}

##########--------data sources----------########

data "terraform_remote_state" "dev-in" {
  backend = "remote"
  config = {
    organization = "siddharth9611"
    workspaces = {
      name = "dev-in"
    }
  }
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "20.31.4"
  cluster_name = "eks-in-cluster"
  cluster_version = "1.31"

  subnet_ids = data.terraform_remote_state.dev-in.outputs.vpc.vpc.private_subnets
  vpc_id =  data.terraform_remote_state.dev-in.outputs.vpc.vpc.vpc_id

  tags = {
    environment = "dev"
  }

  eks_managed_node_groups = {
    dev = {
      min_size     = 1
      max_size     = 1
      desired_size = 1

      instance_types = ["t2.small"]
    }
  }
}


# ###############-----------------eks-cluster--------------#############
#  module "eks-in-cluster" {
#   source = "../../../../../modules/eks_V2"
#   cluster_name = "eks-in-cluster"
#   cluster_version = "1.31"
#   vpc_id = data.terraform_remote_state.dev-in.outputs.vpc.vpc.vpc_id
#   environment = "dev"
#   subnet_ids = data.terraform_remote_state.dev-in.outputs.vpc.vpc.private_subnets
# }