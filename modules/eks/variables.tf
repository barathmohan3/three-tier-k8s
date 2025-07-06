variable "cluster_name" {}
variable "cluster_version" {}
variable "vpc_id" {}
variable "subnet_ids" {
  type = list(string)
}
variable "tags" {
  type = map(string)
}
variable "create_kms_key" {
  type        = bool
  default     = true
  description = "Whether to create a new KMS key for cluster encryption"
}

variable "cluster_encryption_config" {
  type = object({
    provider_key_arn = string
    resources        = list(string)
  })
  default     = null
  description = "Encryption config for the EKS cluster"
}
