module "github_oidc" {
  source = "../../modules/github_oidc_iam"

  repo = var.repo

  environments = {
    dev = {
      role_name   = "gitops-terraform-dev"
      policy_arns = ["arn:aws:iam::aws:policy/AdministratorAccess"]
    }
    staging = {
      role_name   = "gitops-terraform-staging"
      policy_arns = ["arn:aws:iam::aws:policy/AdministratorAccess"]
    }
    prod = {
      role_name   = "gitops-terraform-prod"
      policy_arns = ["arn:aws:iam::aws:policy/AdministratorAccess"]
    }
  }

  tags = {
    ManagedBy = "terraform"
  }
}
