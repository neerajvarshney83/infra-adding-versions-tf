data "aws_iam_role" "frontenddeveloper" {
  name = "milli-dev-frontenddeveloper"
}

data "aws_iam_policy" "AddSecrets-policies" {
  arn = "arn:aws:iam::629239191919:policy/AddSecrets-policies"
}

data "aws_iam_policy" "rw-dev-backend-secretsmanager" {
  arn = "arn:aws:iam::629239191919:policy/rw-dev-backend-secretsmanager"
}

resource "aws_iam_role_policy_attachment" "AddSecrets-policies-frontend" {
  role       = data.aws_iam_role.frontenddeveloper.name
  policy_arn = data.aws_iam_policy.AddSecrets-policies.arn
}

resource "aws_iam_role_policy_attachment" "rw-dev-backend-secretsmanager-frontend" {
  role       = data.aws_iam_role.frontenddeveloper.name
  policy_arn = data.aws_iam_policy.rw-dev-backend-secretsmanager.arn
}


