project_id = "sixth-clone-466418-p4"
topic_name = "my-git-triggered-topic"


pub_sub = [
{
"topic_name"       = "cloud-builds"
"push_subscriptions" = [
    {
              name                       = "slack-subscription"
              push_endpoint              = "https://slack-notifier-ben6i6cm4a-ue.a.run.app"
              oidc_service_account_email = "cloud-run-pubsub-invoker@inm-data-governance-dev.iam.gserviceaccount.com"
              expiration_policy          = "365d"

    },
    {
              name                       = "smtp-subscription"
              push_endpoint              = "https://smtp-notifier-ben6i6cm4a-ue.a.run.app"
              oidc_service_account_email = "cloud-run-pubsub-invoker@inm-data-governance-dev.iam.gserviceaccount.com"
              expiration_policy          = "365d"

    }

]
},
{
"topic_name"       = "tf-apply-approval"
"push_subscriptions" = [
    {
              name                       = "gcb-terraform-project-resources-creator-apply"
              push_endpoint              = "rpc://name:CloudBuildPushEndpoint:gslb:google.pubsub.v1.cloudbuildpushendpoint-prod-global"
              expiration_policy          = "365d"

    }

]
"pull_subscriptions" = [
    {
             name                        = "tf-apply-approval-sub"
             expiration_policy           = "365d"

    }
]
},
{
 "topic_name"       = "tf-recreate-composer"
#  "push_subscriptions" = [
#      {
#                name                       = "gcb-terraform-composer-recreate"
#                push_endpoint              = "rpc://name:CloudBuildPushEndpoint:gslb:google.pubsub.v1.cloudbuildpushendpoint-prod-global"
#                expiration_policy          = ""
#
#      }]
},
{
  "topic_name"       = "tf-destroy-composer"
#   "push_subscriptions" = [
#       {
#                 name                       = "gcb-terraform-composer-recreate"
#                 push_endpoint              = "rpc://name:CloudBuildPushEndpoint:gslb:google.pubsub.v1.cloudbuildpushendpoint-prod-global"
#                 expiration_policy          = ""
#
#       }]
}
]
