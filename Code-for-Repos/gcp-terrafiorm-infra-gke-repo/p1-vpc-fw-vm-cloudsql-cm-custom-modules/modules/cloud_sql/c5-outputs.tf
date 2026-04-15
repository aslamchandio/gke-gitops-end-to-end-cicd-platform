output "mysql_instance_name" {
  value       = google_sql_database_instance.mysql_server.name
  description = "The instance name for the master instance"
}

output "mysql_instance_private_ip" {
  value       = google_sql_database_instance.mysql_server.ip_address
  description = "The IPv4 address assigned for the master instance"
}

output "mysql_private_address" {
  value       = google_sql_database_instance.mysql_server.private_ip_address
  description = "The private IP address assigned for the master instance"
}


output "mysql_instance_connection_name" {
  value       = google_sql_database_instance.mysql_server.connection_name
  description = "The connection name of the master instance to be used in connection strings"
}

output "mydb_schema" {
  value = google_sql_database.mydbschema.name
}

output "mydb_user" {
  value = google_sql_user.users.name
}

output "mydb_password" {
  value     = google_sql_user.users.password
  sensitive = true
}
