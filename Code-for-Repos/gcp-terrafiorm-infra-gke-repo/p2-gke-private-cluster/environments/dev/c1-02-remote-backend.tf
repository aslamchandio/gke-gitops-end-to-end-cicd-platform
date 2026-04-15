terraform {
  backend "gcs" {
    bucket = "my-tf-bucket"
    prefix = "dev/gke-private-cluster-project"

  }
}

