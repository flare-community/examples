module "private_access" {
  source = "git::https://github.com/terraform-google-modules/terraform-google-sql-db//modules/private_service_access?ref=v5.1.1"

  project_id  = var.project
  vpc_network = var.access.network_name
}

module "postgres" {
  source = "git::https://github.com/terraform-google-modules/terraform-google-sql-db//modules/postgresql?ref=v5.1.1"

  name                = local.name
  project_id          = var.project
  database_version    = var.pg_version
  region              = var.region
  deletion_protection = var.deletion_protection
  user_labels         = var.flags

  // master configuration
  tier                            = var.master_config.tier
  zone                            = var.master_config.zone
  availability_type               = var.master_config.availability_type
  maintenance_window_day          = var.master_config.maintenance_window_day
  maintenance_window_hour         = var.master_config.maintenance_window_hour
  maintenance_window_update_track = var.master_config.maintenance_window_update_track
  database_flags                  = local.database_flags

  // db access configuration
  ip_configuration = local.ip_configuration

  // backup configuration
  backup_configuration = {
    enabled                        = var.backup.enabled
    start_time                     = var.backup.start_time
    location                       = var.backup.location
    point_in_time_recovery_enabled = var.backup.point_in_time_recovery_enabled
    transaction_log_retention_days = var.backup.transaction_log_retention_days
    retained_backups               = var.backup.retained_backups
    retention_unit                 = var.backup.retention_unit
  }

  // replicas configuration
  read_replicas = local.replicas

  // default database configuration
  db_name      = var.default_database.db_name
  db_charset   = var.default_database.db_charset
  db_collation = var.default_database.db_collation

  user_name     = var.default_user.user_name
  user_password = var.default_user.user_password

  // additional databases configuration
  additional_databases = local.additional_databases

  // additional users configuration
  additional_users = local.additional_users

  module_depends_on = [module.private_access.peering_completed]
}
