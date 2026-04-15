data "google_compute_zones" "available_zones" {
  region = var.gcp_region_1
  status = "UP"
}


