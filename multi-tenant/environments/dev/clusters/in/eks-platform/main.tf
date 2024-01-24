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

#######______________policy____________########
data "aws_iam_policy" "eks_policy" {
    name = "AmazonEKSClusterPolicy"
    
}

##########________________________IAM_ROLE________________#############

module "eks_role" {
    source = "../../../../../modules/iam"
    name = "eks_role"
    policy_arn = data.aws_iam_policy.eks_policy.arn
}

resource "aws_ebs_volume" "test" {
  availability_zone = "ap-south-1a"
  
}

