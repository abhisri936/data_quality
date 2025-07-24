terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 4.0"
    }
  }

  backend "gcs" {
    bucket  = "my-new-bucket-22"   # Replace with actual bucket name
    prefix  = "terraform/pubsub"
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
}

resource "google_pubsub_topic" "my_topic" {
  name = var.topic_name
}
