environment         = "prod"
region              = "us-east-2"
cluster_name        = "prod-eks"
kubernetes_version  = "1.29"
node_instance_types = ["t3.large"]
desired             = 2
min                 = 1
max                 = 3

state_bucket = "terraform-gitops-file"
lock_table   = "terraform-lock"


tags = {
  project = "terraform_gitops"
  Owner   = "terrence"
}
