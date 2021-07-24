output "vpc" {
  value = google_compute_network.vpc.self_link
}

output "vpc_name" {
  value = google_compute_network.vpc.name
}

output "subnetworks" {
  value = {
    for k, v in google_compute_subnetwork.subnetworks : k => v.self_link
  }
}
