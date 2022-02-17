resource "aws_iam_group" "deployment-ro" {
  name = "deployment-ro"
  path = "/bots/"
}

resource "aws_iam_group_policy_attachment" "deployment-ro-all" {
  group      = aws_iam_group.deployment-ro.name
  policy_arn = "arn:aws:iam::aws:policy/ReadOnlyAccess"
}
resource "aws_iam_group_policy_attachment" "deployment-ro-bucket" {
  group      = aws_iam_group.deployment-ro.name
  policy_arn = "arn:aws:iam::629239191919:policy/us-east-1-dev-gen6-state-bucket-policy"
}

resource "aws_iam_group" "lead-developers" {
  name = "lead-developers"
  path = "/engineering/"
}

resource "aws_iam_group_policy_attachment" "lead-developers-admins" {
  group      = aws_iam_group.lead-developers.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}
resource "aws_iam_group_policy_attachment" "lead-developers-billing" {
  group      = aws_iam_group.lead-developers.name
  policy_arn = aws_iam_policy.billing-rw.arn
}

resource "aws_iam_group" "platform-engineers" {
  name = "platform-engineers"
  path = "/engineering/"
}

resource "aws_iam_group_policy_attachment" "platform-engineers-admins" {
  group      = aws_iam_group.platform-engineers.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}
resource "aws_iam_group_policy_attachment" "platform-engineers-billing" {
  group      = aws_iam_group.platform-engineers.name
  policy_arn = aws_iam_policy.billing-rw.arn
}

resource "aws_iam_group" "frontend-developers" {
  name = "frontend-developers"
  path = "/engineering/"
}

resource "aws_iam_group_policy_attachment" "frontend-developers-ro" {
  group      = aws_iam_group.frontend-developers.name
  policy_arn = "arn:aws:iam::aws:policy/ReadOnlyAccess"
}

resource "aws_iam_group_policy_attachment" "frontend-developers-iam" {
  group      = aws_iam_group.frontend-developers.name
  policy_arn = aws_iam_policy.selfmanage-iam.arn
}

resource "aws_iam_group" "backend-developers" {
  name = "backend-developers"
  path = "/engineering/"
}

resource "aws_iam_group_policy_attachment" "backend-developers-ro" {
  group      = aws_iam_group.backend-developers.name
  policy_arn = "arn:aws:iam::aws:policy/ReadOnlyAccess"
}
resource "aws_iam_group_policy_attachment" "backend-developers-iam" {
  group      = aws_iam_group.backend-developers.name
  policy_arn = aws_iam_policy.selfmanage-iam.arn
}
resource "aws_iam_group_policy_attachment" "backend-developers-secretsmanager" {
  group      = aws_iam_group.backend-developers.name
  policy_arn = aws_iam_policy.secretsmanager-rw.arn
}
resource "aws_iam_group_policy_attachment" "backend-developers-s3" {
  group      = aws_iam_group.backend-developers.name
  policy_arn = aws_iam_policy.s3-ro.arn
}

resource "aws_iam_group" "quality-assurance" {
  name = "quality-assurance"
  path = "/engineering/"
}

resource "aws_iam_group_policy_attachment" "quality-assurance-ro" {
  group      = aws_iam_group.quality-assurance.name
  policy_arn = "arn:aws:iam::aws:policy/ReadOnlyAccess"
}
resource "aws_iam_group_policy_attachment" "quality-assurance-iam" {
  group      = aws_iam_group.quality-assurance.name
  policy_arn = aws_iam_policy.selfmanage-iam.arn
}

resource "aws_iam_group" "security-engineers" {
  name = "security-engineers"
  path = "/engineering/"
}

resource "aws_iam_group_policy_attachment" "security-engineers-ro" {
  group      = aws_iam_group.security-engineers.name
  policy_arn = "arn:aws:iam::aws:policy/ReadOnlyAccess"
}
resource "aws_iam_group_policy_attachment" "security-engineers-iam" {
  group      = aws_iam_group.security-engineers.name
  policy_arn = aws_iam_policy.selfmanage-iam.arn
}
resource "aws_iam_group_policy_attachment" "security-engineers-audit" {
  group      = aws_iam_group.security-engineers.name
  policy_arn = "arn:aws:iam::aws:policy/SecurityAudit"
}
resource "aws_iam_group_policy_attachment" "security-engineers-s3" {
  group      = aws_iam_group.security-engineers.name
  policy_arn = aws_iam_policy.s3-ro.arn
}

resource "aws_iam_group" "project-team" {
  name = "project-team"
  path = "/project/"
}

resource "aws_iam_group_policy_attachment" "project-team-iam" {
  group      = aws_iam_group.project-team.name
  policy_arn = aws_iam_policy.selfmanage-iam.arn
}
resource "aws_iam_group_policy_attachment" "project-team-billing" {
  group      = aws_iam_group.project-team.name
  policy_arn = aws_iam_policy.billing-rw.arn
}
