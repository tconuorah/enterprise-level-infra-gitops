variable "region" {
  type    = string
  default = "us-east-2"
}

variable "state_bucket_name" {
  description = "Globally-unique S3 bucket name for Terraform state"
  type        = string
  default     = "terraform-gitops-file"
}


variable "tags" {
  type    = map(string)
  default = {}
}

variable "lock_table_name" {
  type  = string
  default = "terraform-lock"
}