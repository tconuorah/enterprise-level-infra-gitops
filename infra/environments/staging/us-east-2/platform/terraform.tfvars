environment         = "staging"
region              = "us-east-2"
cluster_name        = "staging-eks"
kubernetes_version  = "1.29"
node_instance_types = ["t3.medium"]
desired             = 2
min                 = 1
max                 = 3

state_bucket = "terraform-gitops-file"

tags = {
  project = "terraform_gitops"
  Owner   = "terrence"
}
