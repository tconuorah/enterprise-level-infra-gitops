data "terraform_remote_state" "networking" {
  backend = "s3"
  config = {
    bucket  = var.state_bucket
    key     = "${var.environment}/${var.region}/networking/terraform.tfstate"
    region  = var.region
    encrypt = true
  }
}

module "ecr" {
  source = "../../../../../../modules/ecr"
  name   = "${var.environment}-app"
  tags   = var.tags
}

module "eks" {
  source = "../../../../../../modules/eks"

  cluster_name       = var.cluster_name
  kubernetes_version = var.kubernetes_version

  vpc_id             = data.terraform_remote_state.networking.outputs.vpc_id
  private_subnet_ids = data.terraform_remote_state.networking.outputs.private_subnet_ids

  node_instance_types = var.node_instance_types
  desired             = var.desired
  min                 = var.min
  max                 = var.max

  tags = var.tags
}
