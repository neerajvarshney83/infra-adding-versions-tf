
provider "sentry" {
  token = var.sentry_token
}

# Create an organization
resource "sentry_organization" "default" {
  name        = "Gen6"
  slug        = "gen6"
  agree_terms = true
}


# Create a team

resource "sentry_team" "gen6" {
    organization = var.organisation
    name         = "Gen6"
    slug         = "gen6"
}

# Create a team
resource "sentry_team" "gen6-operations" {
    organization = var.organisation
    name         = "gen6-operations"
    slug         = "gen6-operations"
}

# Create a team
resource "sentry_team" "gen6engineering" {
    organization = var.organisation
    name         = "gen6engineering"
    slug         = "gen6engineering"
}


# Create a project
resource "sentry_project" "mino-api-tests" {
  organization = var.organisation
  team         = "gen6"
  name         = "mino-api-tests"
  slug         = "mino-api-tests"
  platform     = "java"
  resolve_age  = 0
}

resource "sentry_project" "mino-audit" {
  organization = var.organisation
  team         = "gen6"
  name         = "mino-audit"
  slug         = "mino-audit"
  platform     = "java"
  resolve_age  = 0
}

resource "sentry_project" "mino-insights" {
  organization = var.organisation
  team         = "gen6"
  name         = "mino-insights"
  slug         = "mino-insights"
  platform     = "java"
  resolve_age  = 0
}

resource "sentry_project" "mino-kyc" {
  organization = var.organisation
  team         = "gen6"
  name         = "mino-kyc"
  slug         = "mino-kyc"
  platform     = "java"
  resolve_age  = 0
}
resource "sentry_project" "mino-mobile" {
  organization = var.organisation
  team         = "gen6"
  name         = "mino-ios"
  slug         = "mino-mobile"
  platform     = "react-native"
  resolve_age  = 0
}
resource "sentry_project" "mino-registration" {
  organization = var.organisation
  team         = "gen6"
  name         = "mino-registration"
  slug         = "mino-registration"
  platform     = "java"
  resolve_age  = 0
}
resource "sentry_project" "mino-reporting" {
  organization = var.organisation
  team         = "gen6"
  name         = "mino-reporting"
  slug         = "mino-reporting"
  platform     = "java"
  resolve_age  = 0
}
resource "sentry_project" "mino-test-capabilities" {
  organization = var.organisation
  team         = "gen6"
  name         = "mino-test-capabilities"
  slug         = "mino-test-capabilities"
  platform     = "java"
  resolve_age  = 0
}

resource "sentry_project" "mino-transfer-rules" {
  organization = var.organisation
  team         = "gen6"
  name         = "mino-transfer-rules"
  slug         = "mino-transfer-rules"
  platform     = "java"
  resolve_age  = 0
}

resource "sentry_project" "mino-mobile-gen6-operations" {
  organization = var.organisation
  team         = "gen6"
  name         = "mino-ios"
  slug         = "mino-mobile"
  platform     = "react-native"
  resolve_age  = 0
}

resource "sentry_project" "mino-web-gen6-operations" {
  organization = var.organisation
  team         = "gen6engineering"
  name         = "mino-web"
  slug         = "mino-web"
  platform     = "node"
  resolve_age  = 0
}

resource "sentry_project" "mino-web-pages-gen6-operations" {
  organization = var.organisation
  team         = "gen6engineering"
  name         = "React"
  slug         = "mino-web-pages"
  platform     = "javascript-react"
  resolve_age  = 0
}

resource "sentry_project" "mino-accounts-gen6engineering" {
  organization = var.organisation
  team         = "gen6engineering"
  name         = "mino-accounts"
  slug         = "mino-accounts"
  platform     = "java"
  resolve_age  = 0
}
resource "sentry_project" "mino-admin-gateway-gen6engineering" {
  organization = var.organisation
  team         = "gen6engineering"
  name         = "mino-admin-gateway"
  slug         = "mino-admin-gateway"
  platform     = "java"
  resolve_age  = 0
}
resource "sentry_project" "mino-api-gateway-gen6engineering" {
  organization = var.organisation
  team         = "gen6engineering"
  name         = "mino-api-gateway"
  slug         = "mino-api-gateway"
  platform     = "java"
  resolve_age  = 0
}
resource "sentry_project" "mino-api-tests-gen6engineering" {
  organization = var.organisation
  team         = "gen6"
  name         = "mino-api-tests"
  slug         = "mino-api-tests"
  platform     = "java"
  resolve_age  = 0
}
resource "sentry_project" "mino-audit-gen6engineering" {
  organization = var.organisation
  team         = "gen6"
  name         = "mino-audit"
  slug         = "mino-audit"
  platform     = "java"
  resolve_age  = 0
}
resource "sentry_project" "mino-cards-gen6engineering" {
  organization = var.organisation
  team         = "gen6engineering"
  name         = "mino-cards"
  slug         = "mino-cards"
  platform     = "java"
  resolve_age  = 0
}
resource "sentry_project" "mino-disclosures-gen6engineering" {
  organization = var.organisation
  team         = "gen6engineering"
  name         = "mino-agreements"
  slug         = "mino-disclosures"
  platform     = "java"
  resolve_age  = 0
}
resource "sentry_project" "mino-example-gen6engineering" {
  organization = var.organisation
  team         = "gen6engineering"
  name         = "mino-example"
  slug         = "mino-example"
  platform     = "java"
  resolve_age  = 0
}
resource "sentry_project" "mino-identity-gen6engineering" {
  organization = var.organisation
  team         = "gen6engineering"
  name         = "mino-identity"
  slug         = "mino-identity"
  platform     = "java"
  resolve_age  = 0
}
resource "sentry_project" "mino-insights-gen6engineering" {
  organization = var.organisation
  team         = "gen6"
  name         = "mino-insights"
  slug         = "mino-insights"
  platform     = "java"
  resolve_age  = 0
}
resource "sentry_project" "mino-kyc-gen6engineering" {
  organization = var.organisation
  team         = "gen6"
  name         = "mino-kyc"
  slug         = "mino-kyc"
  platform     = "java"
  resolve_age  = 0
}
resource "sentry_project" "mino-mobile-gen6engineering" {
  organization = var.organisation
  team         = "gen6"
  name         = "mino-ios"
  slug         = "mino-mobile"
  platform     = "react-native"
  resolve_age  = 0
}
resource "sentry_project" "mino-notification-gen6engineering" {
  organization = var.organisation
  team         = "gen6engineering"
  name         = "mino-notification"
  slug         = "mino-notification"
  platform     = "java"
  resolve_age  = 0
}
resource "sentry_project" "mino-onboarding-gen6engineering" {
  organization = var.organisation
  team         = "gen6engineering"
  name         = "mino-onboarding"
  slug         = "mino-onboarding"
  platform     = "java"
  resolve_age  = 0
}
resource "sentry_project" "mino-registration-gen6engineering" {
  organization = var.organisation
  team         = "gen6"
  name         = "mino-registration"
  slug         = "mino-registration"
  platform     = "java"
  resolve_age  = 0
}
resource "sentry_project" "mino-reporting-gen6engineering" {
  organization = var.organisation
  team         = "gen6"
  name         = "mino-reporting"
  slug         = "mino-reporting"
  platform     = "java"
  resolve_age  = 0
}
resource "sentry_project" "mino-test-capabilities-gen6engineering" {
  organization = var.organisation
  team         = "gen6"
  name         = "mino-test-capabilities"
  slug         = "mino-test-capabilities"
  platform     = "java"
  resolve_age  = 0
}
resource "sentry_project" "mino-transactions-gen6engineering" {
  organization = var.organisation
  team         = "gen6engineering"
  name         = "mino-transactions"
  slug         = "mino-transactions"
  platform     = "java"
  resolve_age  = 0
}
resource "sentry_project" "mino-transfer-rules-gen6engineering" {
  organization = var.organisation
  team         = "gen6"
  name         = "mino-transfer-rules"
  slug         = "mino-transfer-rules"
  platform     = "java"
  resolve_age  = 0
}
resource "sentry_project" "mino-web-gen6engineering" {
  organization = var.organisation
  team         = "gen6engineering"
  name         = "mino-web"
  slug         = "mino-web"
  platform     = "node"
  resolve_age  = 0
}
resource "sentry_project" "mino-web-pages-gen6engineering" {
  organization = var.organisation
  team         = "gen6engineering"
  name         = "React"
  slug         = "mino-web-pages"
  platform     = "javascript-react"
  resolve_age  = 0
}
resource "sentry_project" "mino-webhooks-gen6engineering" {
  organization = var.organisation
  team         = "gen6engineering"
  name         = "mino-webhooks"
  slug         = "mino-webhooks"
  platform     = "java"
  resolve_age  = 0
}

