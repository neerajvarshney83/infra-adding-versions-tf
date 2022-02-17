data "aws_iam_policy_document" "AddSecrets-policies" {
  statement {
    sid       = "AccountSecretsAccess"
    actions   = ["secretsmanager:GetResourcePolicy", "secretsmanager:GetRandomPassword","secretsmanager:ListSecrets","secretsmanager:CreateSecret", "secretsmanager:DescribeSecret", "secretsmanager:ListSecretVersionIds","secretsmanager:ValidateResourcePolicy", "secretsmanager:TagResource" ]
    effect    = "Allow"
    resources = ["arn:aws:secretsmanager:*:850315125037:secret:*"]
  }
}

data "aws_iam_policy_document" "assumeEksAccess-mino-prod-ro-policies" {
  statement {
    actions   = ["sts:AssumeRole" ]
    effect    = "Allow"
    resources = ["arn:aws:iam::850315125037:role/EksAccess-mino-prod-ro"]
  }
}

data "aws_iam_policy_document" "CircleCI-S3-build-artifacts-policies" {
  statement {
    sid       = "VisualEditor0"
    actions   = ["s3:*" ]
    effect    = "Allow"
    resources = ["arn:aws:s3:::build-artifacts-circleci", "arn:aws:s3:::*/*" ]
  }
}

data "aws_iam_policy_document" "EKSDevAccess-policies" {
  statement {
    actions   = ["sts:AssumeRole" ]
    effect    = "Allow"
    resources = ["arn:aws:iam::850315125037:role/EksAccess-mino-dev"]
  }
}

data "aws_iam_policy_document" "KMSDevAccess-policies" {
  statement {
    sid       = "KmsDevAccess"
    actions   = ["kms:List*", "kms:Get*", "kms:GenerateRandom", "kms:Describe*", "kms:Create*", "iam:Get*", "kms:Encrypt", "kms:Decrypt", "kms:ReEncrypt*", "kms:GenerateDataKey*" ]
    effect    = "Allow"
    resources = ["*" ]
  }
}

resource "aws_iam_policy" "AddSecrets-policies" {
  name = "AddSecrets-policies"
  description = "Backend developer policy attachment AddSecrets-policies"
  policy = data.aws_iam_policy_document.AddSecrets-policies.json
}

resource "aws_iam_policy" "assumeEksAccess-mino-prod-ro-policies" {
  name = "assumeEksAccess-mino-prod-ro-policies"
  description = "Backend developer policy attachment assumeEksAccess-mino-prod-ro-policies"
  policy = data.aws_iam_policy_document.assumeEksAccess-mino-prod-ro-policies.json
}

resource "aws_iam_policy" "CircleCI-S3-build-artifacts-policies" {
  name = "CircleCI-S3-build-artifacts-policies"
  description = "Backend developer policy attachment CircleCI-S3-build-artifacts-policies"
  policy = data.aws_iam_policy_document.CircleCI-S3-build-artifacts-policies.json
}

resource "aws_iam_policy" "EKSDevAccess-policies" {
  name = "EKSDevAccess-policies"
  description = "Backend developer policy attachment EKSDevAccess-policies"
  policy = data.aws_iam_policy_document.EKSDevAccess-policies.json
}

resource "aws_iam_policy" "KMSDevAccess-policies" {
  name = "KMSDevAccess-policies"
  description = "Backend developer policy attachment KMSDevAccess-policies"
  policy = data.aws_iam_policy_document.KMSDevAccess-policies.json
}

data "aws_iam_role" "developer" {
  name = "milli-prod-developer"
}

resource "aws_iam_role_policy_attachment" "AddSecrets-policies" {
  role       = data.aws_iam_role.developer.name
  policy_arn = aws_iam_policy.AddSecrets-policies.arn
}

resource "aws_iam_role_policy_attachment" "assumeEksAccess-mino-prod-ro-policies" {
  role       = data.aws_iam_role.developer.name
  policy_arn = aws_iam_policy.assumeEksAccess-mino-prod-ro-policies.arn
}

resource "aws_iam_role_policy_attachment" "CircleCI-S3-build-artifacts-policies" {
  role       = data.aws_iam_role.developer.name
  policy_arn = aws_iam_policy.CircleCI-S3-build-artifacts-policies.arn
}

resource "aws_iam_role_policy_attachment" "EKSDevAccess-policies" {
  role       = data.aws_iam_role.developer.name
  policy_arn = aws_iam_policy.EKSDevAccess-policies.arn
}

resource "aws_iam_role_policy_attachment" "KMSDevAccess-policies" {
  role       = data.aws_iam_role.developer.name
  policy_arn = aws_iam_policy.KMSDevAccess-policies.arn
}

resource "aws_iam_role_policy_attachment" "AmazonEC2ContainerRegistryFullAccess-policies" {
  role       = data.aws_iam_role.developer.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryFullAccess"
}

resource "aws_iam_role_policy_attachment" "AmazonS3FullAccess-policies" {
  role       = data.aws_iam_role.developer.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}

resource "aws_iam_role_policy_attachment" "AmazonS3ReadOnlyAccess-policies" {
  role       = data.aws_iam_role.developer.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
}
