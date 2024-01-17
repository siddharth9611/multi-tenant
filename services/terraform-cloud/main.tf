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

data "tfe_organization" "org" {
  name = "siddharth9611"
}

# ------------------ project-------------
resource "tfe_project" "project" {
    name = "multi-tenant"
    organization = data.tfe_organization.org.name
}
