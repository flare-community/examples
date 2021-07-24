provider "google" {
  version = ">=3.0.0"
}

terraform {
  backend "gcs" {}
}

module "dev" {
  source = "../modules"

  hello = "dev"
}
