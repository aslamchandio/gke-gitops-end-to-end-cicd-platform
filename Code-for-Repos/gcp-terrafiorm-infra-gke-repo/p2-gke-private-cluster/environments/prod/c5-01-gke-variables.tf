variable "cluster_name" {
  description = "Name of the GKE cluster. Also used as a prefix in names of related resources."
  type        = string
}


# GCP Compute Engine Machine Type
variable "machine_type" {
  description = "Compute Engine Machine Type"
  #type        = string
  type = map(string)
}

variable "disk_type" {
  description = "Compute Engine Machine Type"
  type        = string
}

variable "disk_size" {
  description = "Compute Engine Machine Type"
  type        = number
}

# GCP Compute Engine Machine Type
variable "enable_private_endpoint" {
  description = "GKE Enable Private Endpoint"
  type        = bool
}

variable "enable_private_nodes" {
  description = "GKE Enable Private Nodes"
  type        = bool
}

variable "deletion_protection" {
  description = "GKE Enable Private Nodes"
  type        = bool
}

variable "remove_default_node_pool" {
  description = "GKE Enable Private Nodes"
  type        = bool
}

variable "master_cidr" {
  description = "US Central1 Region in which GCP Resources to be created"
  type        = string
}

variable "master_gke_version" {
  description = "Kubernetes Version"
  type        = string
}

variable "master_authorized_ip_range" {
  type        = string
  description = "Source IP Address"
}



