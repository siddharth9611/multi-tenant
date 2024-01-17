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


# ------------------ project-------------
resource "tfe_project" "project" {
    name = "multi-tenant"
    organization = "siddharth9611"
}