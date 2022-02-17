variable "sentry_token" {
  type = string
  description = "Sentry API token"
}

variable "organisation" {
  type = string
  description = "Name of sentry organisation"
  default = "gen6"
}

variable "project_name" {
  type = list(string)
  default = ["mino-api-tests", "mino-audit", "mino-insights", "mino-kyc", "mino-mobile", "mino-registration", "mino-reporting", "mino-test-capabilities", "mino-transfer-rules", "mino-web", "mino-web-pages", "mino-accounts", "mino-admin-gateway", "mino-api-gateway" , "mino-cards", "mino-disclosures", "mino-example", "mino-identity","mino-notification" , "mino-onboarding", "mino-transactions", "mino-webhooks"]
  description = "The name of the project to create"
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

variable "milli_id" {
  type = string
  description = "PagerDuty Milli ID"
  default = "78768"
}

variable "sentry_id" {
  type = string
  description = "Sentry serviceID"
  default = "4441"
}
