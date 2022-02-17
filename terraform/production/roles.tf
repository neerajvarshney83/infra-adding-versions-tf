data "aws_iam_group" "developers" {
  group_name = "Developers"
}

data "aws_iam_role" "eks-foundry-mino-prod-node" {
  name = "eks-foundry-mino-prod-node"
}

resource "aws_iam_role_policy" "s3-log-access" {
  name = "s3-log-access"
  role = data.aws_iam_role.eks-foundry-mino-prod-node.id

  policy = <<-EOF
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Action": [
          "kms:CreateGrant",
          "kms:Decrypt",
          "kms:DescribeKey",
          "kms:Encrypt",
          "kms:GenerateDataKey*",
          "kms:ReEncrypt*"
        ],
        "Resource": [
          "arn:aws:kms:us-east-1:850315125037:key/c5792ae1-647a-49d9-b5af-c7d01017f8a1"
        ]
      },
      {
        "Sid": "DownloadandUpload",
        "Action": [
          "s3:GetObject",
          "s3:GetObjectVersion",
          "s3:PutObject",
          "s3:PutObjectAcl"
        ],
        "Effect": "Allow",
        "Resource": "arn:aws:s3:::gen6-prod-prod-logs/*"
      },
      {
        "Sid": "ListBucket",
        "Action": [
          "s3:ListBucket"
        ],
        "Effect": "Allow",
        "Resource": "arn:aws:s3:::gen6-prod-prod-logs"
      }
    ]
  }
  EOF
}

resource "aws_iam_role" "EksAccess-mino-prod-ro" {
  name = "EksAccess-mino-prod-ro"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "AWS": [
          "arn:aws:iam::850315125037:root"
        ]
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF

  tags = {
    tag-key = "tag-value"
  }
}

resource "aws_iam_policy" "assume-readonly" {
  name        = "assumeEksAccess-mino-prod-ro"
  path        = "/"
  description = "Allow assuming role for accessing prod environment read-only"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "sts:AssumeRole"
      ],
      "Effect": "Allow",
      "Resource": "${aws_iam_role.EksAccess-mino-prod-ro.arn}"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "EksAccess-mino-prod-ro" {
  role       = aws_iam_role.EksAccess-mino-prod-ro.name
  policy_arn = "arn:aws:iam::850315125037:policy/RetreiveEksConfig-mino-prod"
}

resource "aws_iam_group_policy_attachment" "AllowDevelopersToReadOnly" {
  group      = data.aws_iam_group.developers.group_name
  policy_arn = aws_iam_policy.assume-readonly.arn
}
