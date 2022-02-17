# Users list
resource "aws_iam_user" "deployment-ro" {
  name = "deployment-ro"
  path = "/bots/"
  tags = {
    Team = "Bots"
    Role = "Read-only GitHub deployment for Terraform/Kops"
  }
}

data "aws_iam_group" "all-users" {
  group_name = "all-users"
}


resource "aws_iam_group_membership" "all-users" {
  name = "tf-testing-group-membership"

  users = [
    aws_iam_user.calumlacroix.name,
    aws_iam_user.renbinden.name,
    aws_iam_user.seungsong.name,
    aws_iam_user.catalinamunteanu.name,
    aws_iam_user.ghazalnaderi.name,
    aws_iam_user.nickfunnell.name,
    aws_iam_user.karimbenfaied.name,
    aws_iam_user.eliottforman.name,
    aws_iam_user.deepaanikhindi.name,
    aws_iam_user.edwingarcia.name,
    aws_iam_user.estohlmann.name,
    aws_iam_user.nickstemp.name,
    aws_iam_user.mattbodholdt.name,
    aws_iam_user.sivatejachallagulla.name,
    aws_iam_user.neerajvarshney.name
  ]

  group = data.aws_iam_group.all-users.group_name
}

resource "aws_iam_user_group_membership" "deployment-ro-groups" {
  user = "deployment-ro"

  groups = [
    "deployment-ro"
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
    "milli-dev-platform",
    "all-users"
  ]
}

resource "aws_iam_user" "neerajvarshney" {
  name = "neerajvarshney"
  path = "/admin/"
  
  tags = {
    Team = "FNBO Engineering"
    Role = "Platform Engineer"
  }
}
resource "aws_iam_user_group_membership" "neerajvarshney-groups" {
  user = aws_iam_user.neerajvarshney.name

  groups = [
    "milli-dev-platform",
    "all-users"
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
    "milli-dev-platform",
    "all-users"
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
    "milli-dev-backenddeveloper",
    "all-users"
  ]
}

resource "aws_iam_user" "seungsong" {
  name = "seungsong"
  path = "/qa/"

  tags = {
    Team = "Consulting Engineering"
    Role = "Quality Assurance Engineer"
  }
}

resource "aws_iam_user" "catalinamunteanu" {
  name = "catalinamunteanu"
  path = "/qa/"

  tags = {
    Team = "Consulting Engineering"
    Role = "Quality Assurance Engineer"
  }
}

resource "aws_iam_user_group_membership" "catalinamunteanu-groups" {
  user = "catalinamunteanu"

  groups = [
    "milli-dev-qualityassurance",
    "all-users"
  ]
}

resource "aws_iam_user_group_membership" "jamiepreddie-groups" {
  user = "seungsong"

  groups = [
    "milli-dev-qualityassurance",
    "all-users"
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
    "milli-dev-frontenddeveloper",
    "milli-dev-security",
    "milli-dev-backenddeveloper",
    "milli-dev-platform",
    "all-users"
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
    "milli-dev-platform",
    "all-users"
  ]
}

resource "aws_iam_user" "karimbenfaied" {
  name = "karimbenfaied"
  path = "/project/"

  tags = {
    Team = "Consulting"
    Role = "Delivery Lead"
  }
}

resource "aws_iam_user_group_membership" "karimbenfaied-groups" {
  user = "karimbenfaied"

  groups = [
    "milli-dev-projectteam",
    "all-users"
  ]
}

resource "aws_iam_user" "eliottforman" {
  name = "eliottforman"
  path = "/project/"

  tags = {
    Team = "Consulting"
    Role = "Project Lead"
  }
}

resource "aws_iam_user_group_membership" "eliottforman-groups" {
  user = "eliottforman"

  groups = [
    "milli-dev-projectteam",
    "all-users"
  ]
}

resource "aws_iam_user" "deepaanikhindi" {
  name = "deepaanikhindi"
  path = "/project/"

  tags = {
    Team = "Consulting"
    Role = "Project Lead"
  }
}

resource "aws_iam_user_group_membership" "deepaanikhindi" {
  user = "deepaanikhindi"

  groups = [
    "milli-dev-projectteam",
    "all-users"
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
    "milli-dev-backenddeveloper",
    "all-users"
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
    "milli-dev-backenddeveloper",
    "all-users"
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
    "milli-dev-backenddeveloper",
    "all-users"
  ]
}

resource "aws_iam_user" "nickstemp" {
  name = "nickstemp"
  path = "/project/"

  tags = {
    Team = "Consulting Engineering"
    Role = "Architect"
  }
}

resource "aws_iam_user_group_membership" "nickstemp-groups" {
  user = "nickstemp"

  groups = [
    "milli-dev-projectteam",
    "all-users"
  ]
}
