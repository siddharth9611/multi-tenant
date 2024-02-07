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

# provider "aws" {
#     region = "ap-south-1"
# }

# #######-----------------policy---------------########

# data "aws_iam_policy" "eks_policy" {
#     name = "AmazonEKSClusterPolicy"
# }

# ##########---------------------IAM_ROLE-------------------#############

# module "eks_role" {
#     source = "../../modules/iam"
#     name = "eks_role"
#     policy_arn = data.aws_iam_policy.eks_policy.arn
# }

