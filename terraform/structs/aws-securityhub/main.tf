variable project {}
variable environment { default = "dev" }
data "aws_caller_identity" "current" {}
provider "aws" {}

resource "aws_config_configuration_recorder_status" "rec" {
  name       = aws_config_configuration_recorder.rec.name
  is_enabled = true
  depends_on = [aws_config_delivery_channel.delivery]
}

resource "aws_kms_key" "bucketenckey" {
  description             = "This key is used to encrypt Config bucket objects"
  deletion_window_in_days = 10
  policy                  = <<POLICY
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Sid": "Enable IAM User Permissions",
        "Effect": "Allow",
        "Principal": {
          "AWS": [
            "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
          ]
        },
        "Action": "kms:*",
        "Resource": "*"
      },
      {
        "Sid": "Allow Config to encrypt logs",
        "Effect": "Allow",
        "Principal": {
          "Service": "config.amazonaws.com"
        },
        "Action": "kms:GenerateDataKey*",
        "Resource": "*"
      },
      {
        "Sid": "Allow Describe Key access",
        "Effect": "Allow",
        "Principal": {
          "Service": ["config.amazonaws.com"]
        },
        "Action": "kms:DescribeKey",
        "Resource": "*"
      }
    ]
  }
  POLICY
}

resource "aws_s3_bucket_policy" "config-policy" {
  bucket = aws_s3_bucket.b.id
  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "AWSConfigBucketPermissionsCheck",
      "Effect": "Allow",
      "Principal": {
        "Service": [
         "config.amazonaws.com"
        ]
      },
      "Action": "s3:GetBucketAcl",
      "Resource": "${aws_s3_bucket.b.arn}"
    },
    {
      "Sid": "AWSConfigBucketExistenceCheck",
      "Effect": "Allow",
      "Principal": {
        "Service": [
          "config.amazonaws.com"
        ]
      },
      "Action": "s3:ListBucket",
      "Resource": "${aws_s3_bucket.b.arn}"
    },
    {
      "Sid": "AWSConfigBucketDelivery",
      "Effect": "Allow",
      "Principal": {
        "Service": [
         "config.amazonaws.com"    
        ]
      },
      "Action": "s3:PutObject",
      "Resource": "${aws_s3_bucket.b.arn}/*",
      "Condition": { 
        "StringEquals": { 
          "s3:x-amz-acl": "bucket-owner-full-control"
        }
      }
    }
  ]
}   
POLICY
}


resource "aws_config_delivery_channel" "delivery" {
  name           = "config-delivery"
  s3_bucket_name = aws_s3_bucket.b.bucket
}

resource "aws_s3_bucket_public_access_block" "bucket-block" {
  bucket = aws_s3_bucket.b.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket" "b" {
  bucket = "${var.project}-${var.environment}-awsconfig"
  acl    = "private"
  versioning {
    enabled = true
  }
  tags = {
    Name = "AWS Config tracking"
  }
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = aws_kms_key.bucketenckey.arn
        sse_algorithm     = "aws:kms"
      }
    }
  }
}

resource "aws_config_configuration_recorder" "rec" {
  name     = "config-recorder"
  role_arn = aws_iam_role.r.arn
  recording_group {
    all_supported                 = true
    include_global_resource_types = true
  }
}
resource "aws_iam_role" "r" {
  name = "config-recorder"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "config.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
POLICY
}
resource "aws_iam_role_policy_attachment" "awsconfig" {
  role       = aws_iam_role.r.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWS_ConfigRole"
}
resource "aws_iam_role_policy" "p" {
  name = "awsconfig-bucket-access"
  role = aws_iam_role.r.id

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "s3:Get*",
        "s3:PutObject"
      ],
      "Effect": "Allow",
      "Resource": [
        "${aws_s3_bucket.b.arn}",
        "${aws_s3_bucket.b.arn}/*"
      ]
    },
    {
      "Effect": "Allow",
      "Action": [
        "kms:Decrypt",
        "kms:DescribeKey",
        "kms:Encrypt",
        "kms:GenerateDataKey*",
        "kms:ReEncrypt*"
      ],
      "Resource": "${aws_kms_key.bucketenckey.arn}"
    }
  ]
}
POLICY
}

resource "aws_securityhub_account" "acc" {}
data "aws_region" "current" {}

resource "aws_securityhub_standards_subscription" "cis" {
  depends_on    = [aws_securityhub_account.acc]
  standards_arn = "arn:aws:securityhub:::ruleset/cis-aws-foundations-benchmark/v/1.2.0"
}
