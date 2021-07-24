output "cluster_id" {
  value = google_container_cluster.k8s.id
}

output "name" {
  value = google_container_cluster.k8s.name
}

output "location" {
  value = google_container_cluster.k8s.location
}

output "master_external_ip" {
  value = google_container_cluster.k8s.endpoint
}

output "pools_ids" {
  value = {
    for k, v in google_container_node_pool.k8s-pools : k => v.id
  }
}

output "pools_igs" {
  value = {
    for k, v in google_container_node_pool.k8s-pools : k => v.instance_group_urls
  }
}

output "service_account" {
  value = google_service_account.service_account.id
}
