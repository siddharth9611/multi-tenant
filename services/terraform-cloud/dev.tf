resource "tfe_variable_set" "dev" {
    name = "dev"
    organization = "siddharth9611"
}


# #----------------------workspace-----------------------

module "dev" {
    source = "./modules/tf_workspace"
    allow_destroy_plan = true
    organisation = data.tfe_organization.org.name
    tf_version = "0.51.1"
    project_id = "prj-btaBdgk3hYr83YvW"
    identifier = "siddharth9611/multi-tenant"
    ingress_submodules = false
    global_remote_state = true
    oauth_token_id = data.tfe_oauth_client.client.oauth_token_id
    queue_all_runs = true
    file_triggers_enabled = true
    variable_set_id = tfe_variable_set.dev.id
    workspace = "dev-in"
    tag_names = "dev"
    trigger_patterns = "multi-tenant/environments/dev/clusters/in/*"
    AWS_REGION = "ap-south-1"
}