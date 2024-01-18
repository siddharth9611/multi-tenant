resource "tfe_variable_set" "dev" {
    name = "dev"
    organization = "siddharth9611"
}


# #----------------------workspace-----------------------

module "dev" {
    source = "./modules/tf_workspace"
    allow_destroy_plan = true
    organisation = data.tfe_organization.org.name
    tf_version = "1.6.6"
    project_id = "prj-SzRmkXQjUJb54uye"
    identifier = "siddharth9611/multi-tenant" #A reference to your VCS repository in the format (<vcs organization>/<repository>)
    ingress_submodules = false
    global_remote_state = true
    oauth_token_id = "ot-GmR4RK6jTNaaMzjm"
    queue_all_runs = true
    file_triggers_enabled = true
    variable_set_id = tfe_variable_set.dev.id
    AWS_REGION = "ap-south-1"
    # workspace = "dev-in"
    # tag_names = ["dev"]
    # working_directory = "multi-tenant/environments/dev/clusters/in"
    # trigger_patterns = ["multi-tenant/environments/dev/clusters/in/*"]

    workspace = {
        dev-in = {
            name = "dev-in"
            tag_names = ["dev"]
            working_directory = "multi-tenant/environments/dev/clusters/in"
            trigger_patterns = ["multi-tenant/environments/dev/clusters/in/*"]
        }

        dev-in-common = {
            name = "dev-in-common"
            tag_names = ["dev"]
            working_directory = "multi-tenant/environments/dev/clusters/in/common"
            trigger_patterns = ["/multi-tenant/environments/dev/clusters/in/common/*"]
        }

        dev-in-eks-platform = {
            name = "dev-in-eks-platform"
            tag_names = ["dev"]
            working_directory = "multi-tenant/environments/dev/clusters/in/eks-platform"
            trigger_patterns = ["/multi-tenant/environments/dev/clusters/in/eks-platform/*"]
        }
    }




}