terraform {
  required_version = ">= 0.13.5"

  required_providers {
    google = "3.72.0"
  }
}

resource "random_id" "suffix" {
  byte_length = 5
}
