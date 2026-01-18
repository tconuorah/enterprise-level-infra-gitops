environment         = "dev"
region              = "us-east-2"
cluster_name        = "dev-eks"
kubernetes_version  = "1.29"
node_instance_types = ["t3.medium"]
desired             = 2
min                 = 1
max                 = 3
project     = "enterprise-level-infra-gitops"

state_bucket = "terraform-gitops-file"

tags = {
  project = "terraform_gitops"
  Owner   = "terrence"
}
