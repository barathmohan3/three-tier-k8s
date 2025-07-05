variable "name" {
  description = "Name prefix for resources"
  type        = string
}

variable "public_subnets" {
  description = "Public subnet IDs"
  type        = list(string)
}

variable "private_subnets" {
  description = "Private subnet IDs"
  type        = list(string)
}

variable "cluster_role_arn" {
  description = "EKS Cluster Role ARN"
  type        = string
}

variable "node_role_arn" {
  description = "EKS Node Role ARN"
  type        = string
}

variable "security_group_ids" {
  description = "Security group IDs for the EKS control plane"
  type        = list(string)
}

variable "cluster_role_dependency" {
  description = "Dependency to ensure IAM role is created before the cluster"
  type        = any
}

variable "eks_oidc_root_ca_thumbprint" {
  description = "OIDC root CA thumbprint for IRSA"
  type        = string
}
