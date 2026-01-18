variable "name" {
  description = "Base name for VPC resources"
  type        = string
}

variable "region" {
  description = "AWS region (used for AZ lookup)"
  type        = string
}

variable "vpc_cidr" {
  description = "VPC CIDR block"
  type        = string
}

variable "public_subnets" {
  description = "List of public subnet CIDRs (one per AZ)"
  type        = list(string)
}

variable "private_subnets" {
  description = "List of private subnet CIDRs (one per AZ)"
  type        = list(string)
}

variable "enable_nat_gateway" {
  description = "Create NAT gateways for private subnets"
  type        = bool
  default     = true
}

variable "single_nat_gateway" {
  description = "If true, create 1 NAT GW; else 1 per AZ"
  type        = bool
  default     = true
}

variable "tags" {
  description = "Tags applied to all resources"
  type        = map(string)
  default     = {}
}
