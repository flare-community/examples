terraform {
  backend "gcs" {
    bucket = "REPLACE_ME"
    prefix = "network"
  }
}

module "dev_network" {
  source = "../../modules/network"

  vpc = {
    project     = "REPLACE_ME"
    name        = "toptal"
    description = "toptal exercise"
  }

  subnetworks = {
    "toptal-k8s" = {
      description = "toptal subnetwork exercise"
      region      = "europe-west1"
      cidr        = "10.126.0.0/15"
      secondary_ranges = [{
        range_name    = "services-cidr"
        ip_cidr_range = "10.122.0.0/15"
        }, {
        range_name    = "pods-cidr"
        ip_cidr_range = "10.124.0.0/15"
      }]
    }
  }
}
