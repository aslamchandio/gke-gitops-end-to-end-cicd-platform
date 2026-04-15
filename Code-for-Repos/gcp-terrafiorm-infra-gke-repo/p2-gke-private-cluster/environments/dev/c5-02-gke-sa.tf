resource "google_service_account" "gke_sa" {
  account_id   = "${local.name}-gke-sa"
  display_name = "Service Account GKE"
}

resource "google_project_iam_member" "member-role" {
  for_each = toset([
    "roles/iam.serviceAccountUser",
    "roles/iam.serviceAccountTokenCreator",
    "roles/artifactregistry.repoAdmin",
    "roles/container.defaultNodeServiceAccount",
    "roles/logging.logWriter",
    "roles/monitoring.metricWriter",
    "roles/storage.admin"

  ])
  role    = each.key
  project = var.gcp_project_id
  member  = "serviceAccount:${google_service_account.gke_sa.email}"
}

