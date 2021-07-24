variable project {}

variable cluster {
  type = object({
    name               = string
    min_master_version = string
    network            = string
    subnetwork         = string
    location           = string
    ip_allocation = object({
      pods_range_name     = string
      services_range_name = string
    })
  })
}


variable node_pools {
  type = map(object({
    min_count = number
    max_count = number
    tags      = list(string)
    node_config = object({
      image_type   = string
      machine_type = string
      disk_size    = number
      preemptible  = bool
    })
  }))
}

variable "service_account" {
  type = object({
    description = string
    roles       = list(string)
  })
  default = {
    description = ""
    roles       = []
  }
}
