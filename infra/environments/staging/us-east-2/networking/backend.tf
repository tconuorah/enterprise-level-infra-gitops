terraform {
  backend "s3" {
    bucket       = "terraform-gitops-file"
    key          = "staging/us-east-2/networking/terraform.tfstate"
    region       = "us-east-2"
    use_lockfile = true
    encrypt      = true
  }
}
