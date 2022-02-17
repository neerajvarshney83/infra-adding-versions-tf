terraform {
  required_providers {
    pagerduty = { source = "PagerDuty/pagerduty", version = "~> 1.9"}
  }
}
# Must export PAGERDUTY_TOKEN as in https://v2.developer.pagerduty.com/docs/authentication .
provider "pagerduty" {}

provider "aws" {}

