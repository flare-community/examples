output "name" {
  value = module.pg.name
}

output "replicas" {
  value = module.pg.replicas
}

output "instances" {
  value = module.pg.instances
}

output "pg_conn" {
  value = module.pg.pg_conn
}

output "reserved_range_name" {
  value = module.pg.reserved_range_name
}

output "reserved_range_address" {
  value = module.pg.reserved_range_address
}

output "private_ip_address" {
  value = module.pg.private_ip_address
}

output "default_db_name" {
  value = module.pg.default_db_name
}

output "default_db_user" {
  value = module.pg.default_db_user
}
