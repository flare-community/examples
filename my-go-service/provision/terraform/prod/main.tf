provider "google" {
  version = ">=3.0.0"
}

terraform {
  backend "gcs" {}
}

module "prod" {
  source = "../modules"

  hello = "prod"
}
