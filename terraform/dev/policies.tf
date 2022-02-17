resource "aws_iam_policy" "selfmanage-iam" {
  name        = "selfmanage-iam"
  description = "Allow users to manager their own IAM details once MFA is active"
  policy      = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "AllowListActions",
            "Effect": "Allow",
            "Action": [
                "iam:ListUsers",
                "iam:ListVirtualMFADevices"
            ],
            "Resource": "*"
        },
        {
            "Sid": "AllowViewAccountInfo",
            "Effect": "Allow",
            "Action": [
                "iam:GetAccountPasswordPolicy",
                "iam:GetAccountSummary"
            ],
            "Resource": "*"
        },
        {
            "Sid": "AllowIndividualUserToListOnlyTheirOwnMFA",
            "Effect": "Allow",
            "Action": [
                "iam:ListMFADevices"
            ],
            "Resource": [
                "arn:aws:iam::*:mfa/*",
                "arn:aws:iam::*:user/*/$${aws:username}"
            ]
        },
        {
            "Sid": "AllowManageOwnPasswords",
            "Effect": "Allow",
            "Action": [
                "iam:ChangePassword",
                "iam:GetUser"
            ],
            "Resource": "arn:aws:iam::*:user/*/$${aws:username}"
        },
        {
            "Sid": "AllowManageOwnAccessKeys",
            "Effect": "Allow",
            "Action": [
                "iam:CreateAccessKey",
                "iam:DeleteAccessKey",
                "iam:ListAccessKeys",
                "iam:UpdateAccessKey"
            ],
            "Resource": "arn:aws:iam::*:user/*/$${aws:username}"
        },
        {
            "Sid": "AllowManageOwnSSHPublicKeys",
            "Effect": "Allow",
            "Action": [
                "iam:DeleteSSHPublicKey",
                "iam:GetSSHPublicKey",
                "iam:ListSSHPublicKeys",
                "iam:UpdateSSHPublicKey",
                "iam:UploadSSHPublicKey"
            ],
            "Resource": "arn:aws:iam::*:user/*/$${aws:username}"
        },
        {
            "Sid": "AllowIndividualUserToManageTheirOwnMFA",
            "Effect": "Allow",
            "Action": [
                "iam:CreateVirtualMFADevice",
                "iam:DeleteVirtualMFADevice",
                "iam:EnableMFADevice",
                "iam:ResyncMFADevice"
            ],
            "Resource": [
                "arn:aws:iam::*:mfa/$${aws:username}",
                "arn:aws:iam::*:user/*/$${aws:username}"
            ]
        },
        {
            "Sid": "AllowIndividualUserToDeactivateOnlyTheirOwnMFAOnlyWhenUsingMFA",
            "Effect": "Allow",
            "Action": [
                "iam:DeactivateMFADevice"
            ],
            "Resource": [
                "arn:aws:iam::*:mfa/$${aws:username}",
                "arn:aws:iam::*:user/*/$${aws:username}"
            ]
        }
    ]
}
POLICY
}

resource "aws_iam_policy" "ecr-rw" {
  name        = "rw-ecr"
  description = "Allow systems and users to manage ECR images"
  policy      = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "ListImagesInRepository",
            "Effect": "Allow",
            "Action": [
                "ecr:ListImages"
            ],
            "Resource": "arn:aws:ecr:::*/*"
        },
        {
            "Sid": "GetAuthorizationToken",
            "Effect": "Allow",
            "Action": [
                "ecr:GetAuthorizationToken"
            ],
            "Resource": "*"
        },
        {
            "Sid": "ManageRepositoryContents",
            "Effect": "Allow",
            "Action": [
                "ecr:GetAuthorizationToken",
                "ecr:BatchCheckLayerAvailability",
                "ecr:GetDownloadUrlForLayer",
                "ecr:GetRepositoryPolicy",
                "ecr:DescribeRepositories",
                "ecr:ListImages",
                "ecr:DescribeImages",
                "ecr:BatchGetImage",
                "ecr:InitiateLayerUpload",
                "ecr:UploadLayerPart",
                "ecr:CompleteLayerUpload",
                "ecr:PutImage",
                "ecr:CreateRepository"
            ],
            "Resource": "arn:aws:ecr:::*/*"
        }
    ]
}
POLICY
}

resource "aws_kms_key" "kms-dev" {
  description             = "Development KMS key"
  deletion_window_in_days = 10
  tags = {
    Environment = "dev"
  }
}

resource "aws_iam_policy" "kms-rw" {
  name        = "rw-dev-kms"
  description = "Allow systems and users to manage data encrypted by Development KMS keys"
  policy      = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "KmsDevAccess",
            "Effect": "Allow",
            "Action": [
                "kms:List*",
                "kms:Get*",
                "kms:Describe*",
                "kms:Create*",
                "iam:Get*",
                "kms:Encrypt",
                "kms:Decrypt",
                "kms:ReEncrypt*",
                "kms:GenerateDataKey*"
            ],
            "Resource": "${aws_kms_key.kms-dev.arn}"
        },
        {
           "Action": [
              "kms:GenerateRandom"
           ],
           "Effect":    "Allow",
           "Resource":  "*",
           "Sid":       "GenerateRandom"
        }
    ]
}
POLICY
}

resource "aws_iam_policy" "secretsmanager-rw" {
  name        = "rw-dev-secretsmanager"
  description = "Allow systems and users to manage secrets in AWS Secrets Manager"
  policy      = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "SMDevAccess",
            "Effect": "Allow",
            "Action": [
                "secretsmanager:*"
            ],
            "Resource": "*"
        },
        {
            "Sid": "SMDevAccessKMS",
            "Effect": "Allow",
            "Action": [
                "kms:Decrypt",
                "kms:Encrypt",
                "kms:GenerateDataKey",
                "kms:ReEncryptFrom",
                "kms:ReEncryptTo"
            ],
            "Resource": "arn:aws:kms:us-east-1:629239191919:key/8176d8f9-3749-4e31-b009-04940dae87bc"
        }
    ]
}
POLICY
}

resource "aws_iam_policy" "s3-ro" {
  name        = "ro-dev-s3"
  description = "Allow systems and users to read environmental, logs and audit S3 buckets"
  policy      = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        { 
            "Sid": "S3DevAccessListAll",
            "Effect": "Allow",
            "Action": [
                "s3:GetAccountPublicAccessBlock",
                "s3:GetBucketAcl",
                "s3:GetBucketLocation",
                "s3:GetBucketPolicyStatus",
                "s3:GetBucketPublicAccessBlock",
                "s3:ListAllMyBuckets"
            ],
            "Resource": "*"
        },
        {
            "Sid": "S3DevAccessList",
            "Effect": "Allow",
            "Action": [
                "s3:ListBucket"
            ],
            "Resource": [ "arn:aws:s3:::us-east-1-dev-gen6-state", "arn:aws:s3:::gen6-dev-audit-trail", "arn:aws:s3:::gen6-dev-int-logs", "arn:aws:s3:::gen6-dev-qa-logs", "arn:aws:s3:::opsui-int.dev.gen6bk.com", "arn:aws:s3:::opsui-qa.dev.gen6bk.com" ]
        },
        {
            "Sid": "S3DevAccessRead",
            "Effect": "Allow",
            "Action": [
                "s3:Get*",
                "s3:List*",
                "s3:Describe*"
            ],
            "Resource": [ "arn:aws:s3:::us-east-1-dev-gen6-state/*", "arn:aws:s3:::gen6-dev-audit-trail/*", "arn:aws:s3:::gen6-dev-int-logs/*", "arn:aws:s3:::gen6-dev-qa-logs/*", "arn:aws:s3:::opsui-int.dev.gen6bk.com/*", "arn:aws:s3:::opsui-qa.dev.gen6bk.com/*" ]
        },
        {
            "Sid": "S3DevAccessKMS",
            "Effect": "Allow",
            "Action": [
                "kms:Decrypt",
                "kms:Encrypt",
                "kms:GenerateDataKey",
                "kms:ReEncryptFrom",
                "kms:ReEncryptTo"
            ],
            "Resource": [ "arn:aws:kms:::key/4af86a56-640f-4b71-a47c-2e80088af4fd",  
                          "arn:aws:kms:::key/4f15d093-41b4-49db-91a7-10a2b1b302b8", 
                          "arn:aws:kms:::key/98b506f7-96c2-492d-b44c-737cd03c09d", 
                          "arn:aws:kms:::key/d00f4910-e74f-4fcc-b24e-2738305ee8ac"] 
        }
    ]
}
POLICY
}

resource "aws_iam_policy" "billing-rw" {
  name        = "rw-dev-billing"
  description = "Allow systems and users to view and manage billing data"
  policy      = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        { 
            "Effect": "Allow",
            "Action": "aws-portal:*Billing",
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "aws-portal:ViewUsage",
                "cur:DescribeReportDefinitions",
                "cur:PutReportDefinition",
                "cur:DeleteReportDefinition",
                "cur:ModifyReportDefinition",
                "pricing:DescribeServices",
                "pricing:GetAttributeValues",
                "pricing:GetProducts",
                "ce:*"
            ],
            "Resource": "*"
        }
    ]
}
POLICY
}
