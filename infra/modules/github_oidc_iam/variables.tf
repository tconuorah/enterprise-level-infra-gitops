variable "repo" { type = string }

variable "create_oidc_provider" {
  type    = bool
  default = true
}

variable "environments" {
  type = map(object({
    role_name   = string
    policy_arns = list(string)
  }))
}

variable "tags" {
  type    = map(string)
  default = {}
}
