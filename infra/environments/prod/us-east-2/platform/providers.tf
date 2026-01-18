provider "aws" {
  region = var.region

  default_tags {
    tags = merge(var.tags, {
      Environment = var.environment
      Region      = var.region
      ManagedBy   = "terraform"
    })
  }
}