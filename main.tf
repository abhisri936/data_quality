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

# CREATES Pubsub Subscriptions
module "pubsub" {
  source             = "terraform-google-modules/pubsub/google"
  version            = "~> 7.0"
  for_each           = { for idx, topic in var.pub_sub : topic.topic_name => topic }
  topic              = each.value.topic_name
  topic_labels       = merge({environment=var.environment_label, application_name=var.dq_application_label}, var.default_labels)
  project_id         = var.service_project_id
  push_subscriptions = each.value.push_subscriptions
  pull_subscriptions = each.value.pull_subscriptions
}