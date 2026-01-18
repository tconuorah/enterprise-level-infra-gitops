terraform {
  backend "s3" {
    bucket         = "terraform-gitops-file"
    key            = "staging/us-east-2/platform/terraform.tfstate"
    region         = "us-east-2"
    dynamodb_table = "terraform-lock"
    encrypt        = true
  }
}
