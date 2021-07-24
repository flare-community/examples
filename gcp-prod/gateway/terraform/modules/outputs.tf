output "ip_address" {
  value = google_compute_global_address.static_ip.address
}

output "ip_name" {
  value = google_compute_global_address.static_ip.name
}

output "dns_entries" {
  value = {
    for k, v in google_endpoints_service.dns_entries : k => v.endpoints
  }
}

output "edge_policy" {
  value = google_compute_security_policy.edge_fw_policy.name
}
