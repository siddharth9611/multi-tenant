resource "tfe_workspace" "workspace" {
    for_each = var.workspace
    name = each.value.name
    organization = try(each.value.organisation, var.organisation)
    terraform_version = var.tf_version
    working_directory = try(each.value.working_directory, var.working_directory)
    allow_destroy_plan = var.allow_destroy_plan
    file_triggers_enabled = var.file_triggers_enabled  ### If enabled, the working directory and trigger prefixes describe a set of files/paths which must contain changes for a VCS push to trigger a run. If disabled, any push will trigger a run.
    global_remote_state = var.global_remote_state ### Whether the workspace allows all workspaces in the organization to access its state data during runs. If false, then only specifically approved workspaces can access its state.
    project_id = try(each.value.project_id, var.project_id)
    queue_all_runs = var.queue_all_runs
    # remote_state_consumer_ids = try(each.value.remote_state_consumer_ids, [])
    speculative_enabled = true
    structured_run_output_enabled = true
    # tag_names = [each.value.tag_names, var.tag_names]
    tag_names = each.value.tag_names
    trigger_patterns = try(each.value.trigger_patterns, var.trigger_patterns)
    vcs_repo {
        identifier = var.identifier
        branch = var.branch
        ingress_submodules = var.ingress_submodules
        oauth_token_id = var.oauth_token_id
        tags_regex = var.tags_regex
    }
}

resource "tfe_workspace_settings" "settings" {
    for_each = var.workspace
    workspace_id = tfe_workspace.workspace[each.value.name].id
    execution_mode = "remote"
}

resource "tfe_workspace_variable_set" "variable_set" {
    for_each = var.workspace
    variable_set_id = try(each.value.tfe_variable_set_id, var.variable_set_id)
    workspace_id = tfe_workspace.workspace[each.value.name].id
}

resource "tfe_variable" "variable" {
    for_each = var.workspace
    key = "AWS_REGION"
    value = try(each.value.AWS_REGION, var.AWS_REGION)
    category = "env"
    workspace_id = tfe_workspace.workspace[each.value.name].id
}


