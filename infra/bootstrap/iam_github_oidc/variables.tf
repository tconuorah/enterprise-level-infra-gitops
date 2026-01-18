variable "region" {
  type    = string
  default = "us-east-2"
}

variable "repo" {
  type    = string
  default = "tconuorah/enterprise-level-infra-gitops"
} # ORG/REPO

variable "tags" {
  type    = map(string)
  default = {}
}


