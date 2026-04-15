# For SSH Allow
output "fw_ingress_ssh_name" {
  value       = google_compute_firewall.fw_ingress_ssh_allow.name
  description = "The name of the firewall rule being created"
}

output "fw_ingress_ssh_network" {
  value       = google_compute_firewall.fw_ingress_ssh_allow.network
  description = "The name of the VPC network where the firewall rule will be applied"
}

output "fw_ingress_ssh_self_link" {
  value       = google_compute_firewall.fw_ingress_ssh_allow.self_link
  description = "The URI of the firewall rule  being created"
}


# For HTTP Allow
output "fw_ingress_http_name" {
  value       = google_compute_firewall.fw_ingress_http_allow.name
  description = "The name of the firewall rule being created"
}

output "fw_ingress_http_network" {
  value       = google_compute_firewall.fw_ingress_http_allow.network
  description = "The name of the VPC network where the firewall rule will be applied"
}

output "fw_ingress_http_self_link" {
  value       = google_compute_firewall.fw_ingress_http_allow.self_link
  description = "The URI of the firewall rule  being created"
}


# For Internal Allow
output "fw_ingress_internal_name" {
  value       = google_compute_firewall.fw_ingress_internal_allow.name
  description = "The name of the firewall rule being created"
}

output "fw_ingress_internal_network" {
  value       = google_compute_firewall.fw_ingress_internal_allow.network
  description = "The name of the VPC network where the firewall rule will be applied"
}

output "fw_ingress_internal_self_link" {
  value       = google_compute_firewall.fw_ingress_internal_allow.self_link
  description = "The URI of the firewall rule  being created"
}

# For IAP Allow
output "fw_ingress_iap_name" {
  value       = google_compute_firewall.fw_ingress_iap_allow.name
  description = "The name of the firewall rule being created"
}

output "fw_ingress_iap_network" {
  value       = google_compute_firewall.fw_ingress_iap_allow.network
  description = "The name of the VPC network where the firewall rule will be applied"
}

output "fw_ingress_iap_self_link" {
  value       = google_compute_firewall.fw_ingress_iap_allow.self_link
  description = "The URI of the firewall rule  being created"
}

output "fw_ingress_iap_target_tags" {
  value       = google_compute_firewall.fw_ingress_iap_allow.target_tags
  description = "The URI of the firewall rule  being created"
}


# For HC Allow
output "fw_ingress_hc_name" {
  value       = google_compute_firewall.fw_ingress_hc_allow.name
  description = "The name of the firewall rule being created"
}

output "fw_ingress_hc_network" {
  value       = google_compute_firewall.fw_ingress_hc_allow.network
  description = "The name of the VPC network where the firewall rule will be applied"
}

output "fw_ingress_hc_self_link" {
  value       = google_compute_firewall.fw_ingress_hc_allow.self_link
  description = "The URI of the firewall rule  being created"
}

# For Egress Sql Allow
output "fw_egress_sql_name" {
  value       = google_compute_firewall.fw_egress_sql_allow.name
  description = "The name of the firewall rule being created"
}

output "fw_egress_sql_network" {
  value       = google_compute_firewall.fw_egress_sql_allow.network
  description = "The name of the VPC network where the firewall rule will be applied"
}

output "fw_egress_sql_self_link" {
  value       = google_compute_firewall.fw_egress_sql_allow.self_link
  description = "The URI of the firewall rule  being created"
}

output "fw_egress_sql_target_tags" {
  value       = google_compute_firewall.fw_egress_sql_allow.target_tags
  description = "The URI of the firewall rule  being created"
}