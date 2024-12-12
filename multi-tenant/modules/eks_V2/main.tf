variable "cluster_endpoint" {}
variable "subnet_ids" {}
variable "cluster_certificate_authority_data" {}
variable "cluster_name" {}
variable "instance_type" {}
variable "cluster_security_group_id" {}
variable "max_size" {}
variable "min_size" {}
variable "vpc_id" {}



module "eks-workers" {
  source  = "cloudposse/eks-workers/aws"
  version = "1.3.0"
  vpc_id = var.vpc_id
  min_size = var.min_size
  subnet_ids = var.subnet_ids
  max_size = var.max_size
  cluster_security_group_id = var.cluster_security_group_id
  instance_type = var.instance_type
  cluster_name = var.cluster_name
  cluster_certificate_authority_data = var.cluster_certificate_authority_data
  cluster_endpoint = var.cluster_endpoint
}