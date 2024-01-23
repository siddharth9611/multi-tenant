terraform {
    cloud {
      organization = "uniphore"
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

##########________________________IAM_ROLE________________#############

data "aws_iam_policy" "eks_policy" {
    name = "AmazonEKSClusterPolicy"
}

resource "aws_iam_role" "eks-role" {
    name = "eks-role"
    assume_role_policy = data.aws_iam_policy.eks_policy.name
}
