variable "repo" {
  description = "ORG/REPO (e.g. tconuorah/terraform-gitops-deploy)"
  type        = string
}

variable "create_oidc_provider" {
  type    = bool
  default = false
}

variable "role_names" {
  type = map(string)
  default = {
    dev     = "gitops-terraform-dev"
    staging = "gitops-terraform-staging"
    prod    = "gitops-terraform-prod"
  }
}

variable "allowed_sub_patterns" {
  description = "env -> list of token.actions sub patterns. If empty, defaults to repo:ORG/REPO:*"
  type        = map(list(string))
  default     = {}
}

variable "attach_policy_arns" {
  type    = map(list(string))
  default = {}
}

variable "tags" {
  type    = map(string)
  default = {}
}
