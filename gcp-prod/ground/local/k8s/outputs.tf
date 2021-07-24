output "cluster_id" {
  value = module.dev_k8s.cluster_id
}

output "name" {
  value = module.dev_k8s.name
}

output "location" {
  value = module.dev_k8s.location
}

output "master_external_ip" {
  value = module.dev_k8s.master_external_ip
}

output "pools_ids" {
  value = module.dev_k8s.pools_ids
}

output "pools_igs" {
  value = module.dev_k8s.pools_igs
}

output "service_account" {
  value = module.dev_k8s.service_account
}
