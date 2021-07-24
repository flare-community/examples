resource "google_container_node_pool" "k8s-pools" {
  for_each = var.node_pools

  name       = each.key
  location   = var.cluster.location
  cluster    = google_container_cluster.k8s.name
  node_count = each.value["min_count"]
  project    = var.project

  autoscaling {
    min_node_count = each.value["min_count"]
    max_node_count = each.value["max_count"]
  }

  management {
    auto_repair  = true
    auto_upgrade = false
  }

  node_config {
    image_type   = each.value["node_config"]["image_type"]
    machine_type = each.value["node_config"]["machine_type"]
    disk_size_gb = each.value["node_config"]["disk_size"]
    preemptible  = each.value["node_config"]["preemptible"]

    service_account = google_service_account.service_account.email
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]

    tags = each.value["tags"]
  }
}
