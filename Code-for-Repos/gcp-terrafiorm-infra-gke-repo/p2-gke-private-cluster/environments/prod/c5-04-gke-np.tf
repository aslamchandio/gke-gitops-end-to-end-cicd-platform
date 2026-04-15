# Resource: GKE Node Pool 1
resource "google_container_node_pool" "nodepool_1" {
  project  = var.gcp_project_id
  name     = "${local.name}-nodepool-01"
  location = var.gcp_region_1
  cluster  = google_container_cluster.gke_cluster.name

  node_count = 1
  node_locations = [
    "${data.google_compute_zones.available_zones.names[0]}",
    "${data.google_compute_zones.available_zones.names[3]}"
  ]

  max_pods_per_node = 110

  autoscaling {
    min_node_count  = 1
    max_node_count  = 2
    location_policy = "BALANCED"
  }


  management {
    auto_repair  = true
    auto_upgrade = true
  }

  timeouts {
    create = "35m"
    update = "35m"
  }

  upgrade_settings {
    strategy        = "SURGE"
    max_surge       = 1
    max_unavailable = 0
  }


  node_config {
    preemptible  = false
    machine_type = var.machine_type["prod"]
    disk_type    = var.disk_type
    disk_size_gb = var.disk_size

    labels = {
      team = "devops"
      env  = "${local.name}-nodepool1"
    }

    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    service_account = google_service_account.gke_sa.email
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
    tags = [
      tolist(data.terraform_remote_state.vpc.outputs.fw_ingress_iap_target_tags)[0],
      tolist(data.terraform_remote_state.vpc.outputs.fw_egress_sql_target_tags)[0]
    ]

  }
}
