data "aws_caller_identity" "current" {}

locals {
  oidc_url = "https://token.actions.githubusercontent.com"

  oidc_provider_arn = ( 
    var.create_oidc_provider
    ? aws_iam_openid_connect_provider.github[0].arn
    : "arn:aws:iam::${data.aws_caller_identity.current.account_id}:oidc-provider/token.actions.githubusercontent.com"
  )

  # Flatten attachments: env -> policy_arn list
  policy_attachments = {
    for item in flatten([
      for env, cfg in var.environments : [
        for arn in cfg.policy_arns : {
          env = env
          arn = arn
        }
      ]
    ]) : "${item.env}|${item.arn}" => item
  }
}

resource "aws_iam_openid_connect_provider" "github" {
  count           = var.create_oidc_provider ? 1 : 0
  url             = local.oidc_url
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = ["6938fd4d98bab03faadb97b34396831e3780aea1"]
  tags            = var.tags
}

data "aws_iam_policy_document" "github_env_trust" {
  for_each = var.environments

  statement {
    sid     = "GitHubActionsOIDC${upper(each.key)}"
    effect  = "Allow"
    actions = ["sts:AssumeRoleWithWebIdentity"]

    principals {
      type        = "Federated"
      identifiers = [local.oidc_provider_arn]
    }

    # aud must be sts.amazonaws.com
    condition {
      test     = "StringEquals"
      variable = "token.actions.githubusercontent.com:aud"
      values   = ["sts.amazonaws.com"]
    }

    # sub should be environment-based and StringLike (matches your JSON)
    condition {
      test     = "StringLike"
      variable = "token.actions.githubusercontent.com:sub"
      values   = ["repo:${var.repo}:environment:${each.key}"]
    }
  }
}

resource "aws_iam_role" "gha" {
  for_each = var.environments

  name               = each.value.role_name
  assume_role_policy = data.aws_iam_policy_document.github_env_trust[each.key].json
  tags               = var.tags
}

resource "aws_iam_role_policy_attachment" "attach" {
  for_each = local.policy_attachments

  role       = aws_iam_role.gha[each.value.env].name
  policy_arn = each.value.arn
}
