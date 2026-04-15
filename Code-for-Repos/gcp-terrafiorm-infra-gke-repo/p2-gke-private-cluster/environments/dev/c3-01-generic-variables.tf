# Input Variables
# GCP Project
variable "gcp_project_id" {
  description = "Project in which GCP Resources to be created"
  type        = string
}

# GCP Region
variable "gcp_region_1" {
  description = "Region in which GCP Resources to be created"
  type        = string
}

# Environment Variable
variable "environment" {
  description = "Environment Variable used as a prefix"
  type        = string
}

# Business Division
variable "business_divsion" {
  description = "Business Division in the large organization this Infrastructure belongs"
  type        = string
}