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

data "tfe_workspace" "main-workspace" {
  name = "terraform-cloud"
  organization = data.tfe_organization.org.name
}

data "tfe_project" "project" {
  name = "multi-tenant"
  organization = data.tfe_organization.org.name
}