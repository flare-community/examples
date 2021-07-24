variable "vpc" {
  type = object({
    project     = string
    name        = string
    description = string
  })
}

variable "subnetworks" {
  type = map(object({
    description = string
    region      = string

    cidr = string
    secondary_ranges = list(object({
      range_name    = string
      ip_cidr_range = string
    }))
  }))
}
