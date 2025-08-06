variable "project_id" {
  type = string
}

variable "region" {
  type    = string
  default = "us-central1"
}

variable "topic_name" {
  type = string
}


variable "pub_sub" {
  description = "Information to create and update cloud pubsub with desired properties"
  type = list(object({
    topic_name  = string
    description = optional(string)
    push_subscriptions = optional(list(object({
      name                       = string,
      ack_deadline_seconds       = optional(number),
      push_endpoint              = optional(string),
      oidc_service_account_email = optional(string),
      audience                   = optional(string),
      expiration_policy          = optional(string),
      dead_letter_topic          = optional(string,""),
      retain_acked_messages      = optional(bool),
      message_retention_duration = optional(string),
      max_delivery_attempts      = optional(number),
      maximum_backoff            = optional(string),
      minimum_backoff            = optional(string),
      filter                     = optional(string),
      enable_message_ordering    = optional(bool),
      no_wrapper                 = optional(bool),
      write_metadata             = optional(bool)

    })), [])
    pull_subscriptions = optional(list(object({
      name                         = string,
      ack_deadline_seconds         = optional(number),
      expiration_policy            = optional(string),
      dead_letter_topic            = optional(string,""),
      max_delivery_attempts        = optional(number),
      retain_acked_messages        = optional(bool),
      message_retention_duration   = optional(string),
      maximum_backoff              = optional(string),
      minimum_backoff              = optional(string),
      filter                       = optional(string),
      enable_message_ordering      = optional(bool),
      service_account              = optional(string),
      enable_exactly_once_delivery = optional(bool)
    })), [])
  }))
  default = []
}

