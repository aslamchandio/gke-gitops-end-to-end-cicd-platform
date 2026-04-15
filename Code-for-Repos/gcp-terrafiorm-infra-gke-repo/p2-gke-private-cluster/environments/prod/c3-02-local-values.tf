# Define Local Values in Terraform
locals {
  # Business division or team name (from variable)
  owners = var.business_divsion # Example: "hr" "it"

  # Environment name such as dev, staging, prod (from variable)
  environment = var.environment # Example: "dev"

  # Standardized naming prefix: "<division>-<env>"
  name = "${var.business_divsion}-${var.environment}"
  #name = "${local.owners}-${local.environment}"
  common_tags = {
    owners      = local.owners
    environment = local.environment
  }

  # Full EKS cluster name used for resource naming and tagging
  gke_cluster_name = "${local.name}-${var.cluster_name}" # Example: "hr-dev-private-cluster"
} 