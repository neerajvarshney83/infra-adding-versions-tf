
provider aws {
  region = "us-east-1"
}

#provider "aws" {}
resource "aws_ecr_repository" "repository" {
  name = var.repository_name
  image_tag_mutability = "MUTABLE"
}

resource "aws_ecr_repository_policy" "dev_access_policy" {
  count = var.additional_aws_account_access_id != null ? 1 : 0
  repository = aws_ecr_repository.repository.name
  policy = <<EOF
{
  "Version" : "2008-10-17",
  "Statement" : [
      {
          "Sid" : "AllowCrossAccountPull",
          "Effect" : "Allow",
          "Principal" : {
            "AWS" : "arn:aws:iam::${var.additional_aws_account_access_id}:root"
          },
          "Action" : [
              "ecr:GetDownloadUrlForLayer",
              "ecr:BatchCheckLayerAvailability",
              "ecr:BatchGetImage"
          ]
      }
  ]
}
EOF
}
