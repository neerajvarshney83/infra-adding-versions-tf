data "aws_iam_policy_document" "ro-dev-backend-s3" {
  statement {
    sid       = "S3DevAccessListAll"
    actions   = ["s3:GetAccountPublicAccessBlock", "s3:GetBucketAcl","s3:GetBucketLocation","s3:GetBucketPolicyStatus", "s3:GetBucketPublicAccessBlock", "s3:ListAllMyBuckets"]
    effect    = "Allow"
    resources = ["*"]
  }
  statement {
    sid       = "S3DevAccessList"
    actions   = ["s3:ListBucket"]
    effect    = "Allow"
    resources = ["arn:aws:s3:::us-east-1-dev-gen6-state","arn:aws:s3:::gen6-dev-audit-trail","arn:aws:s3:::gen6-dev-int-logs","arn:aws:s3:::gen6-dev-qa-logs","arn:aws:s3:::opsui-int.dev.gen6bk.com","arn:aws:s3:::opsui-qa.dev.gen6bk.com"]
  }
  statement {
    sid       = "S3DevAccessRead"
    actions   = ["s3:Get*","s3:List*", "s3:Describe*"]
    effect    = "Allow"
    resources = ["arn:aws:s3:::us-east-1-dev-gen6-state/*","arn:aws:s3:::gen6-dev-audit-trail/*", "arn:aws:s3:::gen6-dev-int-logs/*","arn:aws:s3:::gen6-dev-qa-logs/*","arn:aws:s3:::opsui-int.dev.gen6bk.com/*","arn:aws:s3:::opsui-qa.dev.gen6bk.com/*"]
  }
  statement {
    sid       = "S3DevAccessKMS"
    actions   = ["kms:Decrypt", "kms:Encrypt", "kms:GenerateDataKey", "kms:ReEncryptFrom", "kms:ReEncryptTo"]
    effect    = "Allow"
    resources = ["arn:aws:kms:::key/4af86a56-640f-4b71-a47c-2e80088af4fd", "arn:aws:kms:::key/4f15d093-41b4-49db-91a7-10a2b1b302b8", "arn:aws:kms:::key/98b506f7-96c2-492d-b44c-737cd03c09d", "arn:aws:kms:::key/d00f4910-e74f-4fcc-b24e-2738305ee8ac"]
  }
}

data "aws_iam_policy_document" "rw-dev-backend-secretsmanager" {
  statement {
    sid       = "SMDevAccess"
    actions   = ["secretsmanager:*"]
    effect    = "Allow"
    resources = ["*"]
  }
  statement {
    sid       = "SMDevAccessKMS"
    actions   = ["kms:Decrypt", "kms:Encrypt", "kms:GenerateDataKey", "kms:ReEncryptFrom","kms:ReEncryptTo"]
    effect    = "Allow"
    resources = ["arn:aws:kms:us-east-1:629239191919:key/8176d8f9-3749-4e31-b009-04940dae87bc"]
  }
}

data "aws_iam_policy_document" "rw-dev-billing-document" {
  statement {
    sid       = "AllowViewandManageBillingData"
    actions   = ["aws-portal:*Billing"]
    effect    = "Allow"
    resources = ["*"]
  }
  statement {
    sid       = "ViewUsage"
    actions   = ["aws-portal:ViewUsage", "cur:DescribeReportDefinitions", "cur:PutReportDefinition", "cur:DeleteReportDefinition","cur:ModifyReportDefinition", "pricing:DescribeServices", "pricing:GetAttributeValues", "pricing:GetProducts","ce:*" ]
    effect    = "Allow"
    resources = ["*"]
  }
}

data "aws_iam_policy_document" "selfmanage-iam-document" {
  statement {
    sid       = "AllowListActions"
    actions   = ["iam:ListUsers", "iam:ListVirtualMFADevices"]
    effect    = "Allow"
    resources = ["*"]
  }
  statement {
    sid       = "AllowViewAccountInfo"
    actions   = ["iam:GetAccountPasswordPolicy", "iam:GetAccountSummary"]
    effect    = "Allow"
    resources = ["*"]
  }
  statement {
    sid       = "AllowIndividualUserToListOnlyTheirOwnMFA"
    actions   = ["iam:ListMFADevices"]
    effect    = "Allow"
    resources = ["arn:aws:iam::*:mfa/*", "arn:aws:iam::*:user/*/$${aws:username}" ]
  }
  statement {
    sid       = "AllowManageOwnPasswords"
    actions   = ["iam:ChangePassword", "iam:GetUser" ]
    effect    = "Allow"
    resources = ["arn:aws:iam::*:user/*/$${aws:username}"]
  }
  statement {
    sid       = "AllowManageOwnAccessKeys"
    actions   = ["iam:CreateAccessKey", "iam:DeleteAccessKey", "iam:ListAccessKeys", "iam:UpdateAccessKey" ]
    effect    = "Allow"
    resources = ["arn:aws:iam::*:user/*/$${aws:username}"]
  }
  statement {
    sid       = "AllowManageOwnSSHPublicKeys"
    actions   = ["iam:DeleteSSHPublicKey", "iam:GetSSHPublicKey", "iam:ListSSHPublicKeys", "iam:UpdateSSHPublicKey", "iam:UploadSSHPublicKey" ]
    effect    = "Allow"
    resources = ["arn:aws:iam::*:user/*/$${aws:username}"]
  }
  statement {
    sid       = "AllowIndividualUserToManageTheirOwnMFA"
    actions   = ["iam:CreateVirtualMFADevice", "iam:DeleteVirtualMFADevice", "iam:EnableMFADevice", "iam:ResyncMFADevice" ]
    effect    = "Allow"
    resources = ["arn:aws:iam::*:mfa/$${aws:username}", "arn:aws:iam::*:user/*/$${aws:username}"]
  }
  statement {
    sid       = "AllowIndividualUserToDeactivateOnlyTheirOwnMFAOnlyWhenUsingMFA"
    actions   = ["iam:DeactivateMFADevice"]
    effect    = "Allow"
    resources = ["arn:aws:iam::*:mfa/$${aws:username}", "arn:aws:iam::*:user/*/$${aws:username}" ]
  }
}
resource "aws_iam_policy" "ro-dev-backend-s3" {
  name = "ro-dev-backend-s3"
  description = "Backend developer policy attachment"
  policy = data.aws_iam_policy_document.ro-dev-backend-s3.json
}

resource "aws_iam_policy" "rw-dev-backend-secretsmanager" {
  name = "rw-dev-backend-secretsmanager"
  description = "Backend developer policy attachment"
  policy = data.aws_iam_policy_document.rw-dev-backend-secretsmanager.json
}

resource "aws_iam_policy" "selfmanage-iam-for-all-users" {
  name = "selfmanage-iam-for-all-users"
  description = "selfmanage-iam  policy attachment for all users"
  policy = data.aws_iam_policy_document.selfmanage-iam-document.json
}

data "aws_iam_role" "backenddeveloper" {
  name = "milli-dev-backenddeveloper"
}

data "aws_iam_group" "backenddeveloper" {
  group_name = "milli-dev-backenddeveloper"
}

resource "aws_iam_role_policy_attachment" "ro-dev-backend-s3" {
  role       = data.aws_iam_role.backenddeveloper.name
  policy_arn = aws_iam_policy.ro-dev-backend-s3.arn
}

resource "aws_iam_role_policy_attachment" "selfmanage-iam-document-backend" {
  role       = data.aws_iam_role.backenddeveloper.name
  policy_arn = aws_iam_policy.selfmanage-iam-for-all-users.arn
}

resource "aws_iam_group_policy_attachment" "selfmanage-iam-document-backend" {
  group      = "milli-dev-backenddeveloper"
  policy_arn = aws_iam_policy.selfmanage-iam-for-all-users.arn
}
resource "aws_iam_role_policy_attachment" "rw-dev-backend-secretsmanager" {
  role       = data.aws_iam_role.backenddeveloper.name
  policy_arn = aws_iam_policy.rw-dev-backend-secretsmanager.arn
}

resource "aws_iam_policy" "rw-dev-billing-policy" {
  name = "rw-dev-billing-policy"
  description = "Billing policy attachment"
  policy = data.aws_iam_policy_document.rw-dev-billing-document.json
}

resource "aws_iam_group_policy_attachment" "selfmanage-iam-document-admin" {
  group      = "milli-dev-admin"
  policy_arn = aws_iam_policy.selfmanage-iam-for-all-users.arn
}

resource "aws_iam_group_policy_attachment" "selfmanage-iam-document-developer" {
  group      = "milli-dev-developer"
  policy_arn = aws_iam_policy.selfmanage-iam-for-all-users.arn
}

resource "aws_iam_group_policy_attachment" "selfmanage-iam-document-frontend" {
  group      = "milli-dev-frontenddeveloper"
  policy_arn = aws_iam_policy.selfmanage-iam-for-all-users.arn
}

resource "aws_iam_group_policy_attachment" "selfmanage-iam-document-leaddeveloper" {
  group      = "milli-dev-leaddeveloper"
  policy_arn = aws_iam_policy.selfmanage-iam-for-all-users.arn
}

resource "aws_iam_group_policy_attachment" "selfmanage-iam-document-platform" {
  group      = "milli-dev-platform"
  policy_arn = aws_iam_policy.selfmanage-iam-for-all-users.arn
}

resource "aws_iam_group_policy_attachment" "selfmanage-iam-document-projectteam" {
  group      = "milli-dev-projectteam"
  policy_arn = aws_iam_policy.selfmanage-iam-for-all-users.arn
}

resource "aws_iam_group_policy_attachment" "selfmanage-iam-document-qualityassurance" {
  group      = "milli-dev-qualityassurance"
  policy_arn = aws_iam_policy.selfmanage-iam-for-all-users.arn
}

resource "aws_iam_group_policy_attachment" "selfmanage-iam-document-readonly" {
  group      = "milli-dev-readonly"
  policy_arn = aws_iam_policy.selfmanage-iam-for-all-users.arn
}

resource "aws_iam_group_policy_attachment" "selfmanage-iam-document-security" {
  group      = "milli-dev-security"
  policy_arn = aws_iam_policy.selfmanage-iam-for-all-users.arn
}

# Extra policies as developer in Prod

resource "aws_iam_policy" "AddSecrets-policies" {
  name = "AddSecrets-policies"
  description = "Backend developer policy attachment AddSecrets-policies"
  policy      = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "AccountSecretsAccess",
            "Effect": "Allow",
            "Action": [
                "secretsmanager:GetResourcePolicy",
                "secretsmanager:GetRandomPassword",
                "secretsmanager:ListSecrets",
                "secretsmanager:CreateSecret",
                "secretsmanager:DescribeSecret",
                "secretsmanager:ListSecretVersionIds",
                "secretsmanager:ValidateResourcePolicy",
                "secretsmanager:TagResource"
            ],
            "Resource": "arn:aws:secretsmanager:*:629239191919:secret:*"
        }
    ]
}
POLICY
}


resource "aws_iam_policy" "CircleCI-S3-build-artifacts-policies" {
  name = "CircleCI-S3-build-artifacts-policies"
  description = "Backend developer policy attachment CircleCI-S3-build-artifacts-policies"
  policy      = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": [
                "s3:*"
            ],
            "Resource": [
                "arn:aws:s3:::build-artifacts-circleci",
                "arn:aws:s3:::*/*"
            ]
            
        }
    ]
}
POLICY
}

resource "aws_iam_policy" "KMSDevAccess-policies" {
  name = "KMSDevAccess-policies"
  description = "Backend developer policy attachment KMSDevAccess-policies"
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
                "kms:GenerateRandom",
                "kms:Describe*",
                "kms:Create*",
                "iam:Get*",
                "kms:Encrypt",
                "kms:Decrypt",
                "kms:ReEncrypt*", 
                "kms:GenerateDataKey*"
            ],
            "Resource": [
                "*"
            ]

        }
    ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "AddSecrets-policies" {
  role       = data.aws_iam_role.backenddeveloper.name
  policy_arn = aws_iam_policy.AddSecrets-policies.arn
}

resource "aws_iam_role_policy_attachment" "CircleCI-S3-build-artifacts-policies" {
  role       = data.aws_iam_role.backenddeveloper.name
  policy_arn = aws_iam_policy.CircleCI-S3-build-artifacts-policies.arn
}

resource "aws_iam_role_policy_attachment" "KMSDevAccess-policies" {
  role       = data.aws_iam_role.backenddeveloper.name
  policy_arn = aws_iam_policy.KMSDevAccess-policies.arn
}

resource "aws_iam_role_policy_attachment" "AmazonEC2ContainerRegistryFullAccess-policies" {
  role       = data.aws_iam_role.backenddeveloper.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryFullAccess"
}

resource "aws_iam_role_policy_attachment" "AmazonS3FullAccess-policies" {
  role       = data.aws_iam_role.backenddeveloper.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}

resource "aws_iam_role_policy_attachment" "AmazonS3ReadOnlyAccess-policies" {
  role       = data.aws_iam_role.backenddeveloper.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
}
