#Users list
resource "aws_iam_user" "deployment-ro" {
  name = "deployment-ro"
  path = "/bots/"
  tags = {
    Team = "Bots"
    Role = "Read-only GitHub deployment for Terraform/Kops"
  }
}

resource "aws_iam_user_group_membership" "deploy-ro-groups" {
  user = "deployment-ro"

  groups = [
    "deploy-ro"
  ]
}

resource "aws_iam_user" "mattbodholdt" {
  name = "mattbodholdt"
  path = "/admin/"

  tags = {
    Team = "FNBO Engineering"
    Role = "Platform Engineer"
  }
}

resource "aws_iam_user_group_membership" "mattbodholdt-groups" {
  user = "mattbodholdt"

  groups = [
    "milli-prod-platform",
    "milli-prod-developer"
  ]
}

resource "aws_iam_user" "neerajvarsheny" {
  name = "neerajvarsheny"
  path = "/admin/"

  tags = {
    Team = "FNBO Engineering"
    Role = "Platform Engineer"
  }
}

resource "aws_iam_user_group_membership" "neerajvarsheny-groups" {
  user = "neerajvarsheny"

  groups = [
    "milli-prod-platform",
    "milli-prod-developer"
  ]
}

resource "aws_iam_user" "calumlacroix" {
  name = "calumlacroix"
  path = "/admin/"

  tags = {
    Team = "Consulting Engineering"
    Role = "Lead Engineer"
  }
}

resource "aws_iam_user_group_membership" "calumlacroix-groups" {
  user = "calumlacroix"

  groups = [
    "milli-prod-platform",
    "milli-prod-developer"
  ]
}

resource "aws_iam_user" "renbinden" {
  name = "renbinden"
  path = "/backend/"

  tags = {
    Team = "Consulting Engineering"
    Role = "Kotlin Engineer"
  }
}

resource "aws_iam_user_group_membership" "renbinden-groups" {
  user = "renbinden"

  groups = [
    "milli-prod-developer"
  ]
}

resource "aws_iam_user" "ghazalnaderi" {
  name = "ghazalnaderi"
  path = "/platform/"

  tags = {
    Team = "Consulting Engineering"
    Role = "Platform Engineer"
  }
}

resource "aws_iam_user_group_membership" "ghazalnaderi-groups" {
  user = "ghazalnaderi"

  groups = [
    "milli-prod-security",
    "milli-prod-developer"
  ]
}

resource "aws_iam_user" "nickfunnell" {
  name = "nickfunnell"
  path = "/engineering/"

  tags = {
    Team = "Consulting Engineering"
    Role = "VP Engineering"
  }
}

resource "aws_iam_user_group_membership" "nickfunnell-groups" {
  user = "nickfunnell"

  groups = [
    "milli-prod-platform"
  ]
}

resource "aws_iam_user" "edwingarcia" {
  name = "edwingarcia"
  path = "/backend/"

  tags = {
    Team = "FNBO Engineering"
    Role = "Kotlin Developer"
  }
}

resource "aws_iam_user_group_membership" "edwingarcia-groups" {
  user = "edwingarcia"

  groups = [
    "milli-prod-developer"
  ]
}

resource "aws_iam_user" "sivatejachallagulla" {
  name = "sivatejachallagulla"
  path = "/backend/"

  tags = {
    Team = "FNBO Engineering"
    Role = "Kotlin Developer"
  }
}

resource "aws_iam_user_group_membership" "sivatejachallagulla-groups" {
  user = "sivatejachallagulla"

  groups = [
    "milli-prod-developer"
  ]
}

resource "aws_iam_user" "estohlmann" {
  name = "estohlmann"
  path = "/backend/"

  tags = {
    Team = "FNBO Engineering"
    Role = "Kotlin Developer"
  }
}

resource "aws_iam_user_group_membership" "estohlmann-groups" {
  user = "estohlmann"

  groups = [
    "milli-prod-developer"
  ]
}
