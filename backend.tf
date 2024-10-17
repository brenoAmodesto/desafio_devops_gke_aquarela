terraform {
  backend "gcs" {
    bucket = "desafio_devops_gke"
    prefix = "terraform/state"
  }
}