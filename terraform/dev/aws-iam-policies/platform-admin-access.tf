
data "aws_iam_policy_document" "platform-policy" {
  statement {
    actions   = ["cloudwatch:*"]
    effect    = "Allow"
    resources = ["*"]
  }
  statement {
    actions   = ["sts:*"]
    effect    = "Allow"
    resources = ["*"]
  }
  statement {
    actions   = ["s3:*"]
    effect    = "Allow"
    resources = ["*"]
  }
  statement {
    actions   = ["sns:*"]
    effect    = "Allow"
    resources = ["*"]
  }
  statement {
    actions   = ["route53:*"]
    effect    = "Allow"
    resources = ["*"]
  }
  statement {
    actions   = ["iam:*"]
    effect    = "Allow"
    resources = ["*"]
  }
  statement {
    actions   = ["events:*"]
    effect    = "Allow"
    resources = ["*"]
  }
  statement {
    actions   = ["elasticache:*"]
    effect    = "Allow"
    resources = ["*"]
  }
  statement {
    actions   = ["ec2:*"]
    effect    = "Allow"
    resources = ["*"]
  }
  statement {
    actions   = ["kms:*"]
    effect    = "Allow"
    resources = ["*"]
  }
  statement {
    actions   = ["acm:*"]
    effect    = "Allow"
    resources = ["*"]
  }
  statement {
    actions   = ["sqs:*"]
    effect    = "Allow"
    resources = ["*"]
  }
  statement {
    actions   = ["autoscaling:*"]
    effect    = "Allow"
    resources = ["*"]
  }
  statement {
    actions   = ["elasticloadbalancing:*"]
    effect    = "Allow"
    resources = ["*"]
  }
  statement {
    actions   = ["rds:*"]
    effect    = "Allow"
    resources = ["*"]
  }
  statement {
    actions   = ["config:*"]
    effect    = "Allow"
    resources = ["*"]
  }
  statement {
    actions   = ["cloudfront:*"]
    effect    = "Allow"
    resources = ["*"]
  }
  statement {
    actions   = ["ses:*"]
    effect    = "Allow"
    resources = ["*"]
  }
  statement {
    actions   = ["lambda:*"]
    effect    = "Allow"
    resources = ["*"]
  }
  statement {
    actions   = ["logs:*"]
    effect    = "Allow"
    resources = ["*"]
  }
  statement {
    actions   = ["organizations:*"]
    effect    = "Allow"
    resources = ["*"]
  }
  statement {
    actions   = ["cloudtrail:*"]
    effect    = "Allow"
    resources = ["*"]
  }
  statement {
    actions   = ["guardduty:*"]
    effect    = "Allow"
    resources = ["*"]
  }
  statement {
    actions   = ["securityhub:*"]
    effect    = "Allow"
    resources = ["*"]
  }
  statement {
    actions   = ["health:*"]
    effect    = "Allow"
    resources = ["*"]
  }
  statement {
    actions   = ["secretsmanager:*"]
    effect    = "Allow"
    resources = ["*"]
  }
  statement {
    actions   = ["ds:*"]
    effect    = "Allow"
    resources = ["*"]
  }
  statement {
    actions   = ["ompute-optimizer:*"]
    effect    = "Allow"
    resources = ["*"]
  }
  statement {
    actions   = ["budgets:*"]
    effect    = "Allow"
    resources = ["*"]
  }
  statement {
    actions   = ["aws-portal:*"]
    effect    = "Allow"
    resources = ["*"]
  }
  statement {
    actions   = ["ce:*"]
    effect    = "Allow"
    resources = ["*"]
  }
  statement {
    actions   = ["savingsplans:*"]
    effect    = "Allow"
    resources = ["*"]
  }
  statement {
    actions   = ["ecr-public:*"]
    effect    = "Allow"
    resources = ["*"]
  }
  statement {
    actions   = ["ecr:*"]
    effect    = "Allow"
    resources = ["*"]
  }
  statement {
    actions   = ["redshift:*"]
    effect    = "Allow"
    resources = ["*"]
  }
  statement {
    actions   = ["outposts:*"]
    effect    = "Allow"
    resources = ["*"]
  }
  statement {
    actions   = ["cloudformation:*"]
    effect    = "Allow"
    resources = ["*"]
  }
  statement {
    actions   = ["dlm:*"]
    effect    = "Allow"
    resources = ["*"]
  }
  statement {
    actions   = ["route53domains:*"]
    effect    = "Allow"
    resources = ["*"]
  }
  statement {
    actions   = ["ssm:*"]
    effect    = "Allow"
    resources = ["*"]
  }
  statement {
    actions   = ["support:*"]
    effect    = "Allow"
    resources = ["*"]
  }
  statement {
    actions   = ["application-autoscaling:*"]
    effect    = "Allow"
    resources = ["*"]
  }
  statement {
    actions   = ["schemas:*"]
    effect    = "Allow"
    resources = ["*"]
  }
  statement {
    actions   = ["resource-groups:*"]
    effect    = "Allow"
    resources = ["*"]
  }
  statement {
    actions   = ["applicationinsights:*"]
    effect    = "Allow"
    resources = ["*"]
  }
  statement {
    actions   = ["cognito-idp:*"]
    effect    = "Allow"
    resources = ["*"]
  }
  statement {
    actions   = ["cognito-identity:*"]
    effect    = "Allow"
    resources = ["*"]
  }
  statement {
    actions   = ["wafv2:*"]
    effect    = "Allow"
    resources = ["*"]
  }
  statement {
    actions   = ["waf:*"]
    effect    = "Allow"
    resources = ["*"]
  }
  statement {
    actions   = ["tag:*"]
    effect    = "Allow"
    resources = ["*"]
  }
  statement {
    actions   = ["xray:*"]
    effect    = "Allow"
    resources = ["*"]
  }
  statement {
    actions   = ["purchase-orders:*"]
    effect    = "Allow"
    resources = ["*"]
  }
  statement {
    actions   = ["mediapackage:*"]
    effect    = "Allow"
    resources = ["*"]
  }
  statement {
    actions   = ["mediastore:*"]
    effect    = "Allow"
    resources = ["*"]
  }
  statement {
    actions   = ["cloudhsm:*"]
    effect    = "Allow"
    resources = ["*"]
  }
  statement {
    actions   = ["trustedadvisor:*"]
    effect    = "Allow"
    resources = ["*"]
  }
  statement {
    actions   = ["elasticbeanstalk:*"]
    effect    = "Allow"
    resources = ["*"]
  }
  statement {
    actions   = ["apigateway:*"]
    effect    = "Allow"
    resources = ["*"]
  }
  statement {
    actions   = ["account:*"]
    effect    = "Allow"
    resources = ["*"]
  }
  statement {
    actions   = ["cur:*"]
    effect    = "Allow"
    resources = ["*"]
  }
  statement {
    actions   = ["access-analyzer:*"]
    effect    = "Allow"
    resources = ["*"]
  }
  statement {
    actions   = ["acm-pca:*"]
    effect    = "Allow"
    resources = ["*"]
  }

}


resource "aws_iam_policy" "platform_policy" {
  name        = "PlatformAdministratorAccess"
  description = "Platform adsmin policy attachment"
  policy      = data.aws_iam_policy_document.platform-policy.json
}
