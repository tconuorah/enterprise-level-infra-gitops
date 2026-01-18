module "github_oidc" {
  source = "../../modules/github_oidc_iam"

  repo                 = var.repo
  create_oidc_provider = true

  allowed_sub_patterns = {
    dev     = ["repo:${var.repo}:ref:refs/heads/${var.branch_map.dev}"]
    staging = ["repo:${var.repo}:ref:refs/heads/${var.branch_map.staging}"]
    prod    = ["repo:${var.repo}:ref:refs/heads/${var.branch_map.prod}"]
  }

  # TEMP: start simple. Replace with least-privilege later.
  attach_policy_arns = {
    dev     = ["arn:aws:iam::aws:policy/AdministratorAccess"]
    staging = ["arn:aws:iam::aws:policy/AdministratorAccess"]
    prod    = ["arn:aws:iam::aws:policy/AdministratorAccess"]
  }

  tags = var.tags
}
