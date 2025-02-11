data "aws_caller_identity" "current" {}
locals {
  aws_account_id = data.aws_caller_identity.current.account_id
}

## Github AWS Role
module "github-iam_role" {
  source             = "./resources/aws_iam_role"
  project            = "github-actions"
  name               = "github-actions_role"
  assume_role_policy = data.aws_iam_policy_document.github-assume_role-policy.json
}
### Who can assume the role:
data "aws_iam_policy_document" "github-assume_role-policy" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]
    effect  = "Allow"
    principals {
      type        = "Federated"
      identifiers = ["arn:aws:iam::${local.aws_account_id}:oidc-provider/token.actions.githubusercontent.com"]
    }
    condition {
      test     = "StringEquals"
      variable = "token.actions.githubusercontent.com:aud"
      values   = ["sts.amazonaws.com"]
    }
    condition {
      test     = "StringLike"
      variable = "token.actions.githubusercontent.com:sub"
      values   = ["repo:pabloelisseo/*:*"]
    }
  }
}

### Role permissions
module "s3_fulladmin" { # Manage S3 buckets
  source     = "./resources/aws_iam_role_policy_attachment"
  role       = module.github-iam_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}

module "react-vite-app" {
  source = "./project"
  providers = {
    aws           = aws
    aws.us-east-1 = aws.us-east-1
  }
}
