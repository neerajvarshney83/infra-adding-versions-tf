variable "environment" {}

variable "project" {
  default = "milli"
}

resource "aws_kms_key" "app-files" {
  description = "This key is used to encrypt application data files stored in S3 for the ${var.environment} environment"
  deletion_window_in_days = 30
}

resource "aws_s3_bucket" "account-images" {
  bucket = "${var.project}-${var.environment}-account-images"
  force_destroy = false
  acl = "private"
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = aws_kms_key.app-files.arn
        sse_algorithm = "aws:kms"
      }
    }
  }
  versioning {
    enabled = false
  }
}


resource "aws_s3_bucket_public_access_block" "account-images-access-block" {
  bucket = aws_s3_bucket.account-images.id
  restrict_public_buckets = true
  ignore_public_acls = true
  block_public_acls = true
  block_public_policy = true
}


resource "aws_iam_user" "mino-accounts" {
  name = "mino-accounts-${var.environment}"
  path = "/apps/${var.environment}/"
  tags = {
    Role = "Application"
  }
}

resource "aws_iam_group" "accounts-service" {
  name = "mino-accounts-${var.environment}"
}

resource "aws_iam_group_policy_attachment" "AllowDevelopersToReadOnly" {
  group      = aws_iam_group.accounts-service.name 
  policy_arn = aws_iam_policy.account-images-allow-mino-accounts.arn
}

resource "aws_iam_policy" "account-images-allow-mino-accounts" {
  name = "account-images-allow-mino-accounts-${var.environment}"
  path = "/"
  description = "Allow managing account service images by mino-accounts user in ${var.environment}"

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "AccountImagesIntPolicy",
      "Action": [
         "s3:GetObject",
         "s3:GetObjectVersion",
         "s3:PutObject",
         "s3:PutObjectAcl"
      ],
      "Effect": "Allow",
      "Resource": [
        "${aws_s3_bucket.account-images.arn}/*"
      ]
    },
    {
      "Action": [
        "s3:ListBucket"
      ],
      "Effect": "Allow",
      "Resource": [
        "${aws_s3_bucket.account-images.arn}"
      ]
    },
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
        "${aws_kms_key.app-files.arn}"
      ]
    }
  ]
}
POLICY
}
