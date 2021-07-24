terraform {
  backend "gcs" {
    bucket = "REPLACE_ME"
    prefix = "k8s"
  }
}

data "terraform_remote_state" "network" {
  backend = "gcs"
  config = {
    bucket = "REPLACE_ME"
    prefix = "network"
  }
}

module "dev_k8s" {
  source = "../../modules/k8s"

  project = "REPLACE_ME"

  cluster = {
    name               = "toptal"
    min_master_version = "1.20"
    network            = data.terraform_remote_state.network.outputs.vpc
    subnetwork         = data.terraform_remote_state.network.outputs.subnetworks["toptal-k8s"]
    location           = "europe-west1"
    ip_allocation = {
      pods_range_name     = "pods-cidr"
      services_range_name = "services-cidr"
    }
  }

  node_pools = {
    "toptal" = {
      min_count = 1
      max_count = 1
      tags      = ["toptal"]
      node_config = {
        image_type   = "COS"
        machine_type = "n1-standard-1"
        disk_size    = 50
        preemptible  = true
      }
    }
  }
}
