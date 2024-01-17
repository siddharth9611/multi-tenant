terraform {
  backend "remote" {
    organization = "siddharth9611"
    workspaces {
      name = "terraform-cloud"
    }
  }
  required_providers {
    tfe = {
      source = "hashicorp/tfe"
      version = "0.51.1"
    }
  }
}


# ------------------ project---------------------
module "project" {
    source = "./modules/project"
    organization = "siddharth9611"
    name = "multi-tenant"
}
