terraform {
  backend "gcs" {
    bucket = "my-tf-bucket"
    prefix = "prod/vpc-fw-vm-natgtw-sql-sm-cidr-project"

  }
}

