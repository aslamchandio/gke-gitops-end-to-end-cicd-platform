terraform {
  backend "gcs" {
    bucket = "my-tf-bucket"
    prefix = "dev/vpc-fw-vm-natgtw-sql-sm-cidr-project"

  }
}

