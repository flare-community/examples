data "template_file" "dns_specs" {
  for_each = var.dns_entries

  template = file("${path.module}/dns-spec.yaml")
  vars = {
    ip_address = google_compute_global_address.static_ip.address
    name       = each.key
    project    = var.project
  }
}

resource "google_endpoints_service" "dns_entries" {
  for_each = var.dns_entries

  service_name   = "${each.key}.endpoints.${var.project}.cloud.goog"
  project        = var.project
  openapi_config = data.template_file.dns_specs[each.key].rendered
}
