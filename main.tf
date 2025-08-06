terraform {
  required_version = "~> 1.0"

    required_providers {
      google = {
        source  = "hashicorp/google"
        version = ">= 5.21.0, < 6"
      }

      google-beta = {
        source  = "hashicorp/google-beta"
        version = ">= 4.8.0, < 6"
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


import {
    for_each = { for topic in var.pub_sub : topic.topic_name => topic }
    to       = module.pubsub[each.key].google_pubsub_topic.topic[0]
    id       = each.key
}

# locals {
#   flattened_subscriptions = flatten([
#       for topic in var.pub_sub : [
#         for sub in topic.push_subscriptions : {
#           topic_name  = topic.topic_name
#           subscription_name = sub.name
#         }
#       ]
#     ])
# }
#
# import {
#
#   for_each = { for sub_cnt in local.flattened_subscriptions : "${sub_cnt.topic_name}-${sub_cnt.subscription_name}" => sub_cnt }
#   to       = module.pubsub[each.value.topic_name].google_pubsub_subscription.push_subscriptions[each.value.subscription_name]
#   id       = "projects/${var.service_project_id}/subscriptions/${each.value.subscription_name}"
# }


# CREATES Pubsub Subscriptions
module "pubsub" {
  source             = "terraform-google-modules/pubsub/google"
  version            = "~> 7.0"
  for_each           = { for idx, topic in var.pub_sub : topic.topic_name => topic }
  topic              = each.value.topic_name
  project_id         = var.project_id
  push_subscriptions = each.value.push_subscriptions
  pull_subscriptions = each.value.pull_subscriptions
}