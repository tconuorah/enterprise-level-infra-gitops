environment         = "staging"
region              = "us-east-2"
cluster_name        = "staging-eks"
kubernetes_version  = "1.29"
node_instance_types = ["t3.small"]
desired             = 1
min                 = 1
max                 = 3

state_bucket = "terraform-gitops-file"
lock_table   = "terraform-lock"

tags = {
  project = "terraform_gitops"
  Owner   = "terrence"
}
