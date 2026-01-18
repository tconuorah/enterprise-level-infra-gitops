variable "environment" {
  type = string
}

variable "region" {
  type = string
}

variable "tags" {
  type    = map(string)
  default = {}
}

variable "cluster_name" {
  type = string
}

variable "kubernetes_version" {
  type = string
}

variable "node_instance_types" {
  type = list(string)
}

variable "desired" {
  type = number
}

variable "min" {
  type = number
}

variable "max" {
  type = number
}

# remote state location for networking
variable "state_bucket" { type = string }

