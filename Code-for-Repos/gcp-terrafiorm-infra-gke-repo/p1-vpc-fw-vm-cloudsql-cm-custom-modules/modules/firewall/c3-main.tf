
resource "google_compute_firewall" "fw_ingress_ssh_allow" {
  project     = var.gcp_project_id
  name        = "${var.local_name}-fw-ingress-ssh-allow"
  network     = var.vpc_id
  description = "Creates firewall rule targeting SSH instances"
  allow {
    protocol = "icmp"
  }
  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
  source_ranges = [var.source_ip_ranges]
  target_tags   = ["ssh-allow"]
  priority      = 1000

  log_config {
    metadata = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_firewall" "fw_ingress_http_allow" {
  project     = var.gcp_project_id
  name        = "${var.local_name}-fw-ingress-http-allow"
  network     = var.vpc_id
  description = "Creates firewall rule targeting HTTP instances"
  allow {
    protocol = "tcp"
    ports    = ["80", "443", "8080", "9090"]
  }
  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["http-allow"]
  priority      = 1200

  log_config {
    metadata = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_firewall" "fw_ingress_internal_allow" {
  project     = var.gcp_project_id
  name        = "${var.local_name}-fw-ingress-internal-allow"
  network     = var.vpc_id
  description = "Creates firewall rule targeting Internal instances"

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "udp"
    ports    = ["0-65535"]

  }
  allow {
    protocol = "tcp"
    ports    = ["0-65535"]
  }
  source_ranges = [
    "${var.subnet1_cidr_range}",
    "${var.subnet2_cidr_range}",
    "${var.subnet3_cidr_range}"
  ]

  priority = 1300

  log_config {
    metadata = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_firewall" "fw_ingress_iap_allow" {
  project     = var.gcp_project_id
  name        = "${var.local_name}-fw-ingress-iap-allow"
  network     = var.vpc_id
  description = "Creates firewall rule targeting IAP instances"

  allow {
    protocol = "tcp"
    ports    = ["22", "3389"]
  }
  source_ranges = ["35.235.240.0/20"]
  target_tags   = ["iap-allow"]
  priority      = 1400

  log_config {
    metadata = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_firewall" "fw_ingress_hc_allow" {
  name        = "${var.local_name}-fw-ingress-hc-allow"
  network     = var.vpc_id
  description = "Creates firewall rule targeting IAP instances"

  allow {
    protocol = "tcp"
    ports    = ["80", "8080"]
  }
  direction     = "INGRESS"
  source_ranges = ["35.191.0.0/16", "130.211.0.0/22"]
  priority      = 1500

  log_config {
    metadata = "INCLUDE_ALL_METADATA"
  }
}


resource "google_compute_firewall" "fw_ingress_proxy_allow" {
  name        = "${var.local_name}-fw-ingress-proxy-allow"
  network     = var.vpc_id
  description = "Creates firewall rule targeting IAP instances"

  allow {
    protocol = "tcp"
    ports    = ["80", "443", "8080"]
  }
  direction = "INGRESS"
  source_ranges = [
  "${var.proxy_cidr_range}"]
  priority = 1600

  log_config {
    metadata = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_firewall" "fw_egress_sql_deny" {
  name        = "${var.local_name}-fw-egress-sql-deny"
  network     = var.vpc_id
  description = "Creates firewall rule targeting MySql instances"

  deny {
    protocol = "tcp"
    ports    = ["3306", "5432"]
  }
  direction          = "EGRESS"
  destination_ranges = [var.cloudsql_cidr]
  priority           = 5000

  log_config {
    metadata = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_firewall" "fw_egress_sql_allow" {
  name        = "${var.local_name}-fw-egress-sql-allow"
  network     = var.vpc_id
  description = "Creates firewall rule targeting MySql instances"

  allow {
    protocol = "tcp"
    ports    = ["3306", "5432"]
  }
  direction          = "EGRESS"
  destination_ranges = [var.cloudsql_cidr]
  target_tags        = ["sql-allow"]
  priority           = 1000

  log_config {
    metadata = "INCLUDE_ALL_METADATA"
  }
}
