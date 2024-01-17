resource "tfe_project" "project" {
    name = var.name
    organization = var.organization
}