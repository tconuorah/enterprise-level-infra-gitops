data "aws_caller_identity" "current" {}

locals {
  oidc_url = "https://token.actions.githubusercontent.com"

  env_subs = {
    for env, _name in var.role_names :
    env => (
      length(try(var.allowed_sub_patterns[env], [])) > 0
      ? var.allowed_sub_patterns[env]
      : ["repo:${var.repo}:*"]
    )
  }

  oidc_provider_arn = var.create_oidc_provider ? aws_iam_openid_connect_provider.github[0].arn : "arn:aws:iam::${data.aws_caller_identity.current.account_id}:oidc-provider/token.actions.githubusercontent.com"

  policy_attachments = {
    for item in flatten([
      for env, arns in var.attach_policy_arns : [
        for arn in arns : {
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

data "aws_iam_policy_document" "assume" {
  for_each = var.role_names

  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRoleWithWebIdentity"]

    principals {
      type        = "Federated"
      identifiers = [local.oidc_provider_arn]
    }

    condition {
      test     = "StringEquals"
      variable = "token.actions.githubusercontent.com:aud"
      values   = ["sts.amazonaws.com"]
    }

    condition {
      test     = "StringLike"
      variable = "token.actions.githubusercontent.com:sub"
      values   = local.env_subs[each.key]
    }
  }
}

resource "aws_iam_role" "gha" {
  for_each = var.role_names

  name               = each.value
  assume_role_policy = data.aws_iam_policy_document.assume[each.key].json
  tags               = merge(var.tags, { Environment = each.key })
}

resource "aws_iam_role_policy_attachment" "attach" {
  for_each = local.policy_attachments

  role       = aws_iam_role.gha[each.value.env].name
  policy_arn = each.value.arn
}

