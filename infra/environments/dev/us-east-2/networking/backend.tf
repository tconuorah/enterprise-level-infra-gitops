terraform {
  backend "s3" {
    bucket       = "terraform-gitops-file"
    key          = "dev/us-east-2/networking/terraform.tfstate"
    region       = "us-east-2"
    use_lockfile = true
    encrypt      = true
  }
}
