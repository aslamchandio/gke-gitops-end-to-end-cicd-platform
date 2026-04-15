terraform {
  backend "gcs" {
    bucket = "my-tf-bucket"
    prefix = "prod/gke-private-cluster-project"

  }
}

