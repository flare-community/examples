locals {
  /*
    Random instance name needed because:
    "You cannot reuse an instance name for up to a week after you have deleted an instance."
    See https://cloud.google.com/sql/docs/mysql/delete-instance for details.
  */
  name = "${var.name}-${random_id.suffix.hex}"

  database_flags = concat([{ name = "autovacuum", value = "off" }], var.database_flags)

  ip_configuration = {
    ipv4_enabled        = false
    require_ssl         = var.access.require_ssl
    private_network     = var.access.network_self_link
    authorized_networks = []
  }

  replicas = [for i, replica in var.replicas : {
    name             = tostring(i)
    zone             = replica.zone
    tier             = replica.tier
    ip_configuration = local.ip_configuration
    database_flags   = local.database_flags
    disk_autoresize  = null
    disk_size        = null
    disk_type        = replica.disk_type
    user_labels      = var.flags
  }]

  additional_databases = [for additional_db in var.additional_databases : {
    name      = additional_db.db_name
    charset   = additional_db.db_charset
    collation = additional_db.db_collation
  }]

  additional_users = [for additional_user in var.additional_users : {
    name     = additional_user.user_name
    password = additional_user.user_password
    host     = "localhost"
  }]
}
