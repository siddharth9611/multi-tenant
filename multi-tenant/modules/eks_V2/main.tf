variable "cluster_name" {}
variable "cluster_version" {
  default = "1.31"
}
variable "subnet_ids" {}
variable "vpc_id" {}
variable "environment" {}
variable "min_size" {
  default = 1
}
variable "max_size" {
  default = 1
}
variable "desired_size" {
  default = 1
}
variable "instance_types" {
  default = "t2.small"
}



module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "20.31.4"
  cluster_name = var.cluster_name 
  cluster_version = var.cluster_version

  subnet_ids = var.subnet_ids
  vpc_id = var.vpc_id

  tags = {
    environment = var.environment
  }

  eks_managed_node_groups = {
    dev = {
      min_size     = var.min_size
      max_size     = var.max_size
      desired_size = var.desired_size

      instance_types = [var.instance_types]
    }
  }
}

######################################outputs############################
output "cluster_id" {
  value = module.eks.cluster_id
}