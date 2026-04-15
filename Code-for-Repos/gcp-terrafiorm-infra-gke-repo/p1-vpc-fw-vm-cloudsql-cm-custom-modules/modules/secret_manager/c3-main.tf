resource "google_secret_manager_secret" "db_user_password" {
  secret_id = "${var.local_name}-cloudsql-db-pass"
  labels = {
    env      = "${var.local_name}"
    app-name = "${var.local_name}-secret"
  }

  replication {
    user_managed {
      replicas {
        location = var.gcp_region_1
      }
      replicas {
        location = var.gcp_region_2
      }
    }
  }
}

resource "random_password" "db_password" {
  length  = 16
  special = true
}

resource "google_secret_manager_secret_version" "db_user_password_version" {
  secret      = google_secret_manager_secret.db_user_password.id
  secret_data = random_password.db_password.result
  #secret_data = var.cloudsql_db_pass
}





