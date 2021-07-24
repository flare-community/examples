output "name" {
  value = module.postgres.instance_name
}

output "replicas" {
  value = module.postgres.replicas
}

output "instances" {
  value = module.postgres.instances
}

output "pg_conn" {
  value = module.postgres.instance_connection_name
}

output "reserved_range_name" {
  value = module.private_access.google_compute_global_address_name
}

output "reserved_range_address" {
  value = module.private_access.address
}

output "private_ip_address" {
  value = module.postgres.private_ip_address
}

output "default_db_name" {
  value = var.default_database.db_name
}

output "default_db_user" {
  value = var.default_user.user_name
}
