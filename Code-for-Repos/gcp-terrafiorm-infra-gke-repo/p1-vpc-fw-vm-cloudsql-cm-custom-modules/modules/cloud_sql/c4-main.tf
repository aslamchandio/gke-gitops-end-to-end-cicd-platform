# Time sleep for 30 seconds to allow VPC peering to work
resource "time_sleep" "cloud_sql_delay_create" {
  depends_on      = [google_service_networking_connection.private_vpc_connection]
  create_duration = "30s"
}

# The random_id value that will be added as a suffix to the Cloud SQL instance name
resource "random_id" "db_name_suffix" {
  byte_length = 4
}

# Cloud SQL instance configuration
resource "google_sql_database_instance" "mysql_server" {
  name                = "${var.local_name}-mysql-${random_id.db_name_suffix.hex}"
  region              = var.gcp_region_1
  deletion_protection = false
  database_version    = var.cloudsql_db_version

  settings {
    edition           = "ENTERPRISE"
    tier              = var.cloudsql_db_tier
    availability_type = "REGIONAL"
    #tier = "db-custom-2-6144"
    disk_size             = var.cloudsql_db_disk_size
    disk_type             = var.cloudsql_db_disk_type
    disk_autoresize       = var.cloudsql_db_disk_autoresize
    disk_autoresize_limit = var.cloudsql_db_disk_autoresize_limit

    backup_configuration {
      enabled            = true
      binary_log_enabled = true
      start_time         = "01:00"

      backup_retention_settings {
        retained_backups = 7
      }

    }

    ip_configuration {

      ipv4_enabled                                  = false # Disable public IP
      private_network                               = var.vpc_self_link
      enable_private_path_for_google_cloud_services = true

      /*

      authorized_networks {
        name  = "authorized_networks-cidr2"
        value = var.subnet2_cidr
        #expiration_time = "3021-11-15T16:19:00.094Z"
      }
      authorized_networks {
        name  = "authorized_networks-cidr3"
        value = var.subnet3_cidr
        #expiration_time = "3021-11-15T16:19:00.094Z"
      }

      */
    }

  }
  depends_on = [time_sleep.cloud_sql_delay_create]
}


# Resource: Cloud SQL Database Schema
resource "google_sql_database" "mydbschema" {
  name     = var.cloudsql_db_name
  instance = google_sql_database_instance.mysql_server.name
  #charset   = "utf8"
  #collation = "utf8_general_ci"
}

# Resource: Cloud SQL Database User
resource "google_sql_user" "users" {
  name     = var.cloudsql_db_user
  instance = google_sql_database_instance.mysql_server.name
  host     = "%"
  password = var.db_secret_data
}