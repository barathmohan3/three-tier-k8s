variable "aws_region" {
  description = "The AWS region to deploy to"
  type        = string
}
variable "vpc_cidr" {}
variable "azs" { type = list(string) }
variable "public_subnets" { type = list(string) }
variable "private_subnets" { type = list(string) }
variable "cluster_name" {}
variable "cluster_version" { default = "1.27" }
variable "db_name" {}
variable "db_username" {}
variable "db_password" {}
variable "tags" { type = map(string) }
variable "cluster_role_dependency" {
  type = any
}
