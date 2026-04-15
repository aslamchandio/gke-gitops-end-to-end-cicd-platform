# Terraform Remote State Datasource
data "terraform_remote_state" "vpc" {
  backend = "gcs"
  config = {
    bucket = "my-tf-bucket"
    prefix = "prod/vpc-fw-vm-natgtw-sql-sm-cidr-project"
  }
}

# --------------------------------------------------------------------
# Output the VPC ID from the remote VPC state
# --------------------------------------------------------------------

output "p1_vpc_id" {
  value = data.terraform_remote_state.vpc.outputs.vpc_id
}

# --------------------------------------------------------------------
# Output the VPC Name from the remote VPC state
# --------------------------------------------------------------------

output "p1_vpc_name" {
  value = data.terraform_remote_state.vpc.outputs.vpc_name
}


# --------------------------------------------------------------------
# Output the VPC Self Link from the remote VPC state
# --------------------------------------------------------------------

output "p1_vpc_self_link" {
  value = data.terraform_remote_state.vpc.outputs.vpc_self_link
}

# --------------------------------------------------------------------
# Output the VPC Subnet-1 ID from the remote VPC state
# --------------------------------------------------------------------

output "p1_vpc_subnet1_id" {
  value = data.terraform_remote_state.vpc.outputs.subnet1_id
}

# --------------------------------------------------------------------
# Output the VPC Subnet-1 CIDR from the remote VPC state
# --------------------------------------------------------------------

output "p1_vpc_subnet1_cidr" {
  value = data.terraform_remote_state.vpc.outputs.subnet1_cidr
}


# --------------------------------------------------------------------
# Output the VPC Subnet-2 CIDR from the remote VPC state
# --------------------------------------------------------------------

output "p1_vpc_subnet2_cidr" {
  value = data.terraform_remote_state.vpc.outputs.subnet2_cidr
}

# --------------------------------------------------------------------
# Output the VPC Subnet-2 CIDR from the remote VPC state
# --------------------------------------------------------------------

output "p1_vpc_subnet3_cidr" {
  value = data.terraform_remote_state.vpc.outputs.subnet3_cidr
}

# --------------------------------------------------------------------
# Output the VPC Pod-1 CIDR Name from the remote VPC state
# --------------------------------------------------------------------

output "p1_vpc_pod_cidr1_name" {
  value = data.terraform_remote_state.vpc.outputs.pod_cidr1_name
}

# --------------------------------------------------------------------
# Output the VPC Pod-1 CIDR Name from the remote VPC state
# --------------------------------------------------------------------

output "p1_vpc_pod_cidr2_name" {
  value = data.terraform_remote_state.vpc.outputs.pod_cidr2_name
}

# --------------------------------------------------------------------
# Output the VPC Pod-1 CIDR Name from the remote VPC state
# --------------------------------------------------------------------

output "p1_vpc_service_cidr_name" {
  value = data.terraform_remote_state.vpc.outputs.service_cidr_name
}

# --------------------------------------------------------------------
# Output the VPC Firewall Ingress IAP TAG  from the remote VPC state
# --------------------------------------------------------------------

output "p1_fw_ingress_iap_target_tags" {
  value = data.terraform_remote_state.vpc.outputs.fw_ingress_iap_target_tags
}

# --------------------------------------------------------------------
# Output the VPC Firewall Ingress IAP TAG  from the remote VPC state
# --------------------------------------------------------------------

output "p1_fw_egress_sql_target_tags" {
  value = data.terraform_remote_state.vpc.outputs.fw_egress_sql_target_tags
}




