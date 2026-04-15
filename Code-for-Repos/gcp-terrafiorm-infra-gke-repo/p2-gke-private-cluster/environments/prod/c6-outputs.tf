# Terraform Outputs
output "gke_cluster_name" {
  description = "GKE cluster name"
  value       = google_container_cluster.gke_cluster.name
}

output "gke_cluster_location" {
  description = "GKE Cluster location"
  value       = google_container_cluster.gke_cluster.location
}

output "gke_cluster_endpoint" {
  description = "GKE Cluster Endpoint"
  value       = google_container_cluster.gke_cluster.endpoint
}

output "gke_cluster_master_version" {
  description = "GKE Cluster master version"
  value       = google_container_cluster.gke_cluster.master_version
}

output "gke_cluster_to_configure_kubectl" {
  description = "Command to update local kubeconfig to connect to the GKE cluster"
  value       = "gcloud container clusters get-credentials ${local.gke_cluster_name} --region ${var.gcp_region_1} --project ${var.gcp_project_id}"
}
