resource "aws_iam_policy" "rw-dev-billing-document" {
  name = "rw-dev-billing-document"
  description = "Project team billing policy attachment"
  policy = data.aws_iam_policy_document.rw-dev-billing-document.json
}

data "aws_iam_role" "projectteam" {
  name = "milli-dev-projectteam"
}

resource "aws_iam_role_policy_attachment" "w-dev-billing-document" {
  role       = data.aws_iam_role.projectteam.name
  policy_arn = aws_iam_policy.rw-dev-billing-document.arn
}
