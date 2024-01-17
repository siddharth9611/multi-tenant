variable "workspace" {}

variable "organisation" {}

variable "project_id" {}

variable "tf_version" {}

variable "allow_destroy_plan" {
    type = bool
    default = false
}

variable "identifier" {}

variable "global_remote_state" {
    type = bool
    default = false
}

variable "ingress_submodules" {}

variable "oauth_token_id" {}

variable "queue_all_runs" {
    default = false
    type = bool
}

variable "tags_regex" {
    default = null
}

variable "branch" {
    default = "main"
}

variable "file_triggers_enabled" {
    type = bool
    default = false
}

variable "trigger_patterns" {
    default = null
}

variable "AWS_REGION" {
    default = "ap-south-1"
}

# variable "variable_set_id" {
#     default = null
# }


variable "tag_names" {}












