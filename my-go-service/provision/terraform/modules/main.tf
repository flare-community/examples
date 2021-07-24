terraform {
  required_version = ">= 0.13.5"

  required_providers {
    google = "3.0.0"
  }
}

provider "google" {
  version = ">=3.0.0"
}

resource "null_resource" "echo" {
  provisioner "local-exec" {
    command = "echo $VAR"
    environment = {
      VAR = var.hello
    }
  }

  triggers = {
    always_run = timestamp()
  }
}
