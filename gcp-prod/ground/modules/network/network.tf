resource "google_compute_network" "vpc" {
  project     = var.vpc.project
  name        = var.vpc.name
  description = var.vpc.description

  routing_mode            = "GLOBAL"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "subnetworks" {
  for_each = var.subnetworks

  project     = var.vpc.project
  name        = each.key
  description = each.value["description"]

  ip_cidr_range = each.value["cidr"]
  network       = google_compute_network.vpc.id
  region        = each.value["region"]

  secondary_ip_range = each.value["secondary_ranges"]
}
