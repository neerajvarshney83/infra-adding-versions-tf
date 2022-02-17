provider "sentry" {
  token = var.sentry_token
}

resource "sentry_project" "default" {
  organization = var.organisation
  team         = var.team
  name         = var.project_name
  slug         = var.project_name
  platform     = "java"
}

resource "sentry_rule" "int" {
  depends_on   = [sentry_project.default]
  name         = "Int Rule"
  organization = var.organisation
  project      = var.project_name
  frequency    = 30

  conditions = []

  filters = [
    {
      key   = "environment",
      match = "eq",
      name  = "The event's tags match environment equals int",
      value = "int",
      id    = "sentry.rules.filters.tagged_event.TaggedEventFilter"
    }
  ]

  actions = [
    {
      targetType = "IssueOwners",
      id = "sentry.mail.actions.NotifyEmailAction",
      targetIdentifier = "",
      name = "Send an email to IssueOwners"
    },
    {
      name       = "Send a notification to the Gen6Ventures Slack workspace to #alerts-sentry-int and show tags [environment] in notification",
      tags       = "environment",
      channel_id = var.slack_int_channel_id,
      workspace  = var.slack_workspace,
      id         = "sentry.integrations.slack.notify_action.SlackNotifyServiceAction",
      channel    = "#alerts-sentry-int"
    }
  ]
  
}
resource "sentry_rule" "fnbo-dev" {
  depends_on   = [sentry_project.default]
  name         = "FNBO Dev Rule"
  organization = var.organisation
  project      = var.project_name
  frequency    = 30

  conditions = []

  filters = [
    {
      key   = "environment",
      match = "eq",
      name  = "The event's tags match environment equals fnbo-dev",
      value = "fnbo-dev",
      id    = "sentry.rules.filters.tagged_event.TaggedEventFilter"
    }
  ]

  actions = [
    {
      targetType = "IssueOwners",
      id = "sentry.mail.actions.NotifyEmailAction",
      targetIdentifier = "",
      name = "Send an email to IssueOwners"
    },
    {
      name       = "Send a notification to the Gen6Ventures Slack workspace to #alerts-sentry-fnbo-dev and show tags [environment] in notification",
      tags       = "environment",
      channel_id = var.slack_fnbo_dev_channel_id,
      workspace  = var.slack_workspace,
      id         = "sentry.integrations.slack.notify_action.SlackNotifyServiceAction",
      channel    = "#alerts-sentry-fnbo-dev"
    }
  ]
}

resource "sentry_rule" "qa" {
  depends_on   = [sentry_project.default]
  name         = "QA Rule"
  organization = var.organisation
  project      = var.project_name
  frequency    = 30

  conditions = []

  filters = [
    {
      key   = "environment",
      match = "eq",
      name  = "The event's tags match environment equals qa",
      value = "qa",
      id    = "sentry.rules.filters.tagged_event.TaggedEventFilter"
    }
  ]

  actions = [
    {
      targetType = "IssueOwners",
      id = "sentry.mail.actions.NotifyEmailAction",
      targetIdentifier = "",
      name = "Send an email to IssueOwners"
    },
    {
      name       = "Send a notification to the Gen6Ventures Slack workspace to #alerts-sentry-qa and show tags [environment] in notification",
      tags       = "environment",
      channel_id = var.slack_qa_channel_id,
      workspace  = var.slack_workspace,
      id         = "sentry.integrations.slack.notify_action.SlackNotifyServiceAction",
      channel    = "#alerts-sentry-qa"
    }
  ]
}

resource "sentry_rule" "prod" {
  depends_on   = [sentry_project.default]
  name         = "Prod Rule"
  organization = var.organisation
  project      = var.project_name
  frequency    = 30

  conditions = []

  filters = [
    {
      key   = "environment",
      match = "eq",
      name  = "The event's tags match environment equals prod",
      value = "prod",
      id    = "sentry.rules.filters.tagged_event.TaggedEventFilter"
    }
  ]

  actions = [
    {
      targetType = "IssueOwners",
      id = "sentry.mail.actions.NotifyEmailAction",
      targetIdentifier = "",
      name = "Send an email to IssueOwners"
    },
    {
      name       = "Send a notification to the Gen6Ventures Slack workspace to #alerts-sentry-prod and show tags [environment] in notification",
      tags       = "environment",
      channel_id = var.slack_prod_channel_id,
      workspace  = var.slack_workspace,
      id         = "sentry.integrations.slack.notify_action.SlackNotifyServiceAction",
      channel    = "#alerts-sentry-prod"
    }
  ]
}
