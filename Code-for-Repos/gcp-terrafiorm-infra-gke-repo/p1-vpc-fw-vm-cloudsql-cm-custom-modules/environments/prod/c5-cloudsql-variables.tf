# Cloud SQL Database version

variable "cloudsql_db_version" {
  description = "Cloud SQL MySQL DB Database version"
  type        = string
}

variable "cloudsql_db_tier" {
  description = "Cloud SQL MySQL DB Database tier"
  type        = string
}

variable "cloudsql_db_disk_size" {
  description = "Cloud SQL MySQL DB Database Disk Size"
  type        = number
}

variable "cloudsql_db_disk_type" {
  description = "Cloud SQL MySQL DB Database Disk Type"
  type        = string
}

variable "cloudsql_db_disk_autoresize" {
  description = "Cloud SQL MySQL DB Database Disk Size"
  type        = bool
}

variable "cloudsql_db_disk_autoresize_limit" {
  description = "Cloud SQL MySQL DB Database Disk Size"
  type        = number
}

variable "cloudsql_db_name" {
  description = "Cloud SQL DB Name"
  type        = string
}

variable "cloudsql_db_user" {
  description = "Cloud SQL DB User name"
  type        = string
}

variable "private_ip_range" {
  description = "Compute Engine Machine Type"
  type        = string
}

variable "cloudsql_cidr" {
  description = "Cloud SQL MySQL DB Database tier"
  type        = string
}

