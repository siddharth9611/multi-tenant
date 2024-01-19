

module "main_vpc" {
  source = "../../modules/vpc"
  name = "EKS_test"
  environment = "dev"
  vpc_cidr = "10.0.0.0/16"
  avail_zone = ["ap-south-1a", "ap-south-1b", "ap-south-1c"]
  pub_subnet_cidr = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
  prv_subnet_cidr = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}