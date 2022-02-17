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
    condition {
         test = "Bool"
         variable = "aws:MultiFactorAuthPresent"
         values = [
             "true",
         ]
    }    
    effect    = "Allow"
    resources = ["arn:aws:iam::*:mfa/$${aws:username}", "arn:aws:iam::*:user/*/$${aws:username}" ]
  }
}

resource "aws_iam_policy" "selfmanage-iam-for-all-users" {
  name = "selfmanage-iam-for-all-users"
  description = "selfmanage-iam  policy attachment for all users"
  policy = data.aws_iam_policy_document.selfmanage-iam-document.json
}

resource "aws_iam_group_policy_attachment" "selfmanage-iam-document-backend" {
  group      = "milli-prod-backenddeveloper"
  policy_arn = aws_iam_policy.selfmanage-iam-for-all-users.arn
}

resource "aws_iam_group_policy_attachment" "selfmanage-iam-document-admin" {
  group      = "milli-prod-admin"
  policy_arn = aws_iam_policy.selfmanage-iam-for-all-users.arn
}

resource "aws_iam_group_policy_attachment" "selfmanage-iam-document-developer" {
  group      = "milli-prod-developer"
  policy_arn = aws_iam_policy.selfmanage-iam-for-all-users.arn
}

resource "aws_iam_group_policy_attachment" "selfmanage-iam-document-frontend" {
  group      = "milli-prod-frontenddeveloper"
  policy_arn = aws_iam_policy.selfmanage-iam-for-all-users.arn
}

resource "aws_iam_group_policy_attachment" "selfmanage-iam-document-leaddeveloper" {
  group      = "milli-prod-leaddeveloper"
  policy_arn = aws_iam_policy.selfmanage-iam-for-all-users.arn
}

resource "aws_iam_group_policy_attachment" "selfmanage-iam-document-platform" {
  group      = "milli-prod-platform"
  policy_arn = aws_iam_policy.selfmanage-iam-for-all-users.arn
}

resource "aws_iam_group_policy_attachment" "selfmanage-iam-document-projectteam" {
  group      = "milli-prod-projectteam"
  policy_arn = aws_iam_policy.selfmanage-iam-for-all-users.arn
}

resource "aws_iam_group_policy_attachment" "selfmanage-iam-document-qualityassurance" {
  group      = "milli-prod-qualityassurance"
  policy_arn = aws_iam_policy.selfmanage-iam-for-all-users.arn
}

resource "aws_iam_group_policy_attachment" "selfmanage-iam-document-readonly" {
  group      = "milli-prod-readonly"
  policy_arn = aws_iam_policy.selfmanage-iam-for-all-users.arn
}

resource "aws_iam_group_policy_attachment" "selfmanage-iam-document-security" {
  group      = "milli-prod-security"
  policy_arn = aws_iam_policy.selfmanage-iam-for-all-users.arn
}
