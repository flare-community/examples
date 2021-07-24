variable "project" {}
variable "name" {}
variable "pg_version" {
  type    = string
  default = "POSTGRES_9_6"
}
variable "region" {
  type    = string
  default = "europe-west1"
}
variable "deletion_protection" {
  type    = bool
  default = false
}

variable "master_config" {
  type = object({
    tier                            = string
    zone                            = string
    availability_type               = string
    maintenance_window_day          = number
    maintenance_window_hour         = number
    maintenance_window_update_track = string
  })
  default = {
    tier                            = "db-custom-1-3840"
    zone                            = "europe-west1-b"
    availability_type               = "REGIONAL"
    maintenance_window_day          = 7
    maintenance_window_hour         = 12
    maintenance_window_update_track = "stable"
  }
}

variable "database_flags" {
  type = list(object({
    name  = string
    value = string
  }))
  default = []
}

variable "flags" {
  type    = map(string)
  default = {}
}

variable "access" {
  type = object({
    network_name      = string
    network_self_link = string
    require_ssl       = bool
  })
}

variable "backup" {
  type = object({
    enabled                        = bool
    start_time                     = string
    location                       = string
    point_in_time_recovery_enabled = bool
    transaction_log_retention_days = number
    retained_backups               = number
    retention_unit                 = string
  })
  default = {
    enabled                        = true
    start_time                     = "20:55"
    location                       = null
    point_in_time_recovery_enabled = false
    transaction_log_retention_days = null
    retained_backups               = 365
    retention_unit                 = "COUNT"
  }
}

variable "replicas" {
  type = list(object({
    zone      = string
    tier      = string
    disk_type = string
  }))
  default = []
}

variable "default_database" {
  type = object({
    db_name      = string
    db_charset   = string
    db_collation = string
  })
  default = {
    db_name      = "default"
    db_charset   = "UTF8"
    db_collation = "en_US.UTF8"
  }
}

variable "default_user" {
  type = object({
    user_name     = string
    user_password = string
  })
}

variable "additional_databases" {
  type = list(object({
    db_name      = string
    db_charset   = string
    db_collation = string
  }))
  default = []
}

variable "additional_users" {
  type = list(object({
    user_name     = string
    user_password = string
  }))
  default = []
}
