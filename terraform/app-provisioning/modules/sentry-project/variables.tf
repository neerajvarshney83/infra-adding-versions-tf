
variable "sentry_token" {
  type = string
  description = "Sentry API token"
}

variable "project_name" {
  type = string
  description = "The name of the project to create"
}

variable "organisation" {
  type = string
  description = "Name of sentry organisation"
  default = "gen6"
}

variable "team" {
  type = string
  description = "The name of the team that should own the project"
  default = "gen6engineering"
}

variable "slack_workspace" {
  type = string
  description = "Slack workspace ID"
  default = "32781"
}

variable "slack_int_channel_id" {
  type = string
  description = "Slack Int alerts channel ID"
  default = "C01BLJCK63T"
}

variable "slack_fnbo_dev_channel_id" {
  type = string
  description = "Slack fnbo-dev alerts channel ID"
  default = "C028FJ66U6T"
}

variable "slack_qa_channel_id" {
  type = string
  description = "Slack QA alerts channel ID"
  default = "CLUNWR9E3"
}

variable "slack_prod_channel_id" {
  type = string
  description = "Slack Prod alerts channel ID"
  default = "CS78S7D1B"
}

