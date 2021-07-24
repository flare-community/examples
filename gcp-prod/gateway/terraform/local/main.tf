terraform {
  backend "gcs" {
    bucket = "REPLACE_ME"
    prefix = "gateway"
  }
}

module "gateway" {
  source = "../modules/"

  project     = "REPLACE_ME"
  dns_entries = ["api", "frontend", "grafana"]
}
