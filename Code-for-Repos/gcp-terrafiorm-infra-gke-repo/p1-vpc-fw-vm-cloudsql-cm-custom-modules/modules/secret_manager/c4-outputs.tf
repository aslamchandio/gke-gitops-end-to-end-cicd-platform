output "db_secret_data" {
  value = google_secret_manager_secret_version.db_user_password_version.secret_data
}


