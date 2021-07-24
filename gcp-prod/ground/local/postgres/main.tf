terraform {
  backend "gcs" {
    bucket = "REPLACE_ME"
    prefix = "postgres"
  }
}

data "terraform_remote_state" "network" {
  backend = "gcs"
  config = {
    bucket = "REPLACE_ME"
    prefix = "network"
  }
}

module "pg" {
  source = "../../modules/postgres"

  project = "REPLACE_ME"

  name = "toptal"

  default_user = {
    user_name     = "test"
    user_password = "test"
  }

  access = {
    network_name      = data.terraform_remote_state.network.outputs.vpc_name
    network_self_link = data.terraform_remote_state.network.outputs.vpc
    require_ssl       = false
  }
}
