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
  depends_on = [ module.eks-in-cluster ]
  name = module.eks-in-cluster.cluster_id
}

data "aws_eks_cluster_auth" "cluster_auth" {
  depends_on = [ module.eks-in-cluster ]
  name = module.eks-in-cluster.cluster_id
}

provider "kubernetes" {
  alias = "EKS_k8s-provider"
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



###############-----------------eks-cluster--------------#############
 module "eks-in-cluster" {
  source = "../../../../../modules/eks_V2"
  cluster_name = "eks-in-cluster"
  cluster_version = "1.31"
  vpc_id = data.terraform_remote_state.dev-in.outputs.vpc.vpc.vpc_id
  environment = "dev"
  subnet_ids = data.terraform_remote_state.dev-in.outputs.vpc.vpc.private_subnets
}