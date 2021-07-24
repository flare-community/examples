resource "google_container_cluster" "k8s" {
  project = var.project
  name    = var.cluster.name

  location   = var.cluster.location
  network    = var.cluster.network
  subnetwork = var.cluster.subnetwork

  min_master_version    = var.cluster.min_master_version
  enable_shielded_nodes = true
  networking_mode       = "VPC_NATIVE"

  # We can't create a cluster with no node pool defined, but we want to only use
  # separately managed node pools. So we create the smallest possible default
  # node pool and immediately delete it.
  remove_default_node_pool = true
  initial_node_count       = 1

  lifecycle {
    ignore_changes = [node_pool]
  }

  maintenance_policy {
    daily_maintenance_window {
      start_time = "04:00"
    }
  }

  ip_allocation_policy {
    cluster_secondary_range_name  = var.cluster.ip_allocation.pods_range_name
    services_secondary_range_name = var.cluster.ip_allocation.services_range_name
  }
}

data "google_container_cluster" "k8s_info" {
  name     = google_container_cluster.k8s.name
  project  = google_container_cluster.k8s.project
  location = google_container_cluster.k8s.location
}
