cluster_name = "gkecluster1"

machine_type = {
  "test" = "e2-micro"
  "dev"  = "e2-small"
  "prod" = "e2-medium"
}

disk_type = "pd-balanced"
disk_size = 30

enable_private_endpoint = false
enable_private_nodes    = true

deletion_protection      = false
remove_default_node_pool = false

master_cidr                = "172.16.2.0/28"
master_gke_version         = "1.35.1-gke.1396002"
master_authorized_ip_range = "39.100.11.78/32"


