# VPC Module OUTPUT

output "vpc_name" {
  value       = module.vpc.vpc_name
  description = "The name of the VPC being created"
}

output "vpc_id" {
  value = module.vpc.vpc_id
}

output "vpc_self_link" {
  value       = module.vpc.vpc_self_link
  description = "The URI of the VPC being created"
}

## First Subnet Output

output "subnet1_name" {
  value       = module.vpc.subnet1_name
  description = "The name of the subnetwork"
}

output "subnet1_cidr" {
  value       = module.vpc.subnet1_cidr
  description = "Primary CIDR range"
}

output "subnet1_id" {
  description = "Subnet ID"
  value       = module.vpc.subnet1_id
}

output "subnet1_self_link" {
  value       = module.vpc.subnet1_self_link
  description = "Primary CIDR range"
}

output "pod_cidr1_name" {
  value       = module.vpc.pod_cidr1_name
  description = "Name of the secondary CIDR range"
}

output "pod_cidr1_range" {
  value       = module.vpc.pod_cidr1
  description = "Secondary CIDR range"
}
output "pod_cidr2_name" {
  value       = module.vpc.pod_cidr1_name
  description = "Name of the secondary CIDR range"
}

output "pod_cidr2_range" {
  value       = module.vpc.pod_cidr2
  description = "Secondary CIDR range"
}

output "service_cidr_name" {
  value       = module.vpc.service_cidr_name
  description = "Name of the secondary CIDR range"
}

output "service_cidr_range" {
  value       = module.vpc.service_cidr
  description = "Secondary CIDR range"
}

## Second Subnet Output

output "subnet2_name" {
  value       = module.vpc.subnet2_name
  description = "The name of the subnetwork"
}

output "subnet2_cidr" {
  value       = module.vpc.subnet2_cidr
  description = "Primary CIDR range"
}

output "subnet2_self_link" {
  value       = module.vpc.subnet2_self_link
  description = "Primary CIDR range"
}

output "subnet2_id" {
  description = "Subnet ID"
  value       = module.vpc.subnet2_id
}

## Third Subnet Output

output "subnet3_name" {
  value       = module.vpc.subnet3_name
  description = "The name of the subnetwork"
}

output "subnet3_cidr" {
  value       = module.vpc.subnet3_cidr
  description = "Primary CIDR range"
}

output "subnet3_self_link" {
  value       = module.vpc.subnet3_self_link
  description = "Primary CIDR range"
}

output "subnet3_id" {
  description = "Subnet ID"
  value       = module.vpc.subnet3_id
}

## Regional Proxy-Only Subne Output

output "regional_proxy_subnet_name" {
  value       = module.vpc.regional_proxy_subnet_name
  description = "The name of the subnetwork"
}

output "regional_proxy_subnet_cidr" {
  value       = module.vpc.regional_proxy_subnet_cidr
  description = "Primary CIDR range"
}

output "regional_proxy_subnet_id" {
  description = "Subnet ID"
  value       = module.vpc.regional_proxy_subnet_id
}

# Firwwall Module OUTPUT

## For SSH Allow
output "fw_ingress_ssh_name" {
  value       = module.firewall.fw_ingress_ssh_name
  description = "The name of the firewall rule being created"
}

output "fw_ingress_ssh_network" {
  value       = module.firewall.fw_ingress_ssh_network
  description = "The name of the VPC network where the firewall rule will be applied"
}

output "fw_ingress_ssh_self_link" {
  value       = module.firewall.fw_ingress_ssh_self_link
  description = "The URI of the firewall rule  being created"
}


## For HTTP Allow
output "fw_ingress_http_name" {
  value       = module.firewall.fw_ingress_http_name
  description = "The name of the firewall rule being created"
}

output "fw_ingress_http_network" {
  value       = module.firewall.fw_ingress_http_network
  description = "The name of the VPC network where the firewall rule will be applied"
}

output "fw_ingress_http_self_link" {
  value       = module.firewall.fw_ingress_http_self_link
  description = "The URI of the firewall rule  being created"
}


## For Internal Allow
output "fw_ingress_internal_name" {
  value       = module.firewall.fw_ingress_internal_name
  description = "The name of the firewall rule being created"
}

output "fw_ingress_internal_network" {
  value       = module.firewall.fw_ingress_internal_network
  description = "The name of the VPC network where the firewall rule will be applied"
}

output "fw_ingress_internal_self_link" {
  value       = module.firewall.fw_ingress_internal_self_link
  description = "The URI of the firewall rule  being created"
}

## For IAP Allow
output "fw_ingress_iap_name" {
  value       = module.firewall.fw_ingress_iap_name
  description = "The name of the firewall rule being created"
}

output "fw_ingress_iap_network" {
  value       = module.firewall.fw_ingress_iap_network
  description = "The name of the VPC network where the firewall rule will be applied"
}

output "fw_ingress_iap_self_link" {
  value       = module.firewall.fw_ingress_iap_self_link
  description = "The URI of the firewall rule  being created"
}

output "fw_ingress_iap_target_tags" {
  value       = module.firewall.fw_ingress_iap_target_tags
  description = "The URI of the firewall rule  being created"
}

# For Health Check Allow
output "fw_ingress_hc_name" {
  value       = module.firewall.fw_ingress_hc_name
  description = "The name of the firewall rule being created"
}

output "fw_ingress_hc_network" {
  value       = module.firewall.fw_ingress_hc_network
  description = "The name of the VPC network where the firewall rule will be applied"
}

output "fw_ingress_hc_self_link" {
  value       = module.firewall.fw_ingress_hc_self_link
  description = "The URI of the firewall rule  being created"
}

# For Mysql Egress Sql Allow

output "fw_egress_sql_target_tags" {
  value       = module.firewall.fw_egress_sql_target_tags
  description = "The URI of the firewall rule  being created"
}

# VM Module OUTPUT

output "gke_vm_private_ip" {
  value = module.vm.gke_vm_private_ip
}

output "gke_vm1_private_ip" {
  value = module.vm.gke_vm_private_ip
}

## NatGW Module OUTPUT

output "natgw_public_ip1" {
  value       = module.natgw.natgw_public_ip1
  description = "The public IP address of the newly created Nat Gateway"
}

output "natgw_public_ip2" {
  value       = module.natgw.natgw_public_ip2
  description = "The public IP address of the newly created Nat Gateway"
}
