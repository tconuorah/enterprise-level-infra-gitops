variable "region" {
  type    = string
  default = "us-east-2"
}

variable "repo" {
  type    = string
  default = "tconuorah/terraform-gitops-deploy"
} # ORG/REPO

variable "tags" {
  type    = map(string)
  default = {}
}

# Strong enterprise default: lock env roles to branches
variable "branch_map" {
  type = map(string)
  default = {
    dev     = "dev"
    staging = "staging"
    prod    = "main"
  }
}
