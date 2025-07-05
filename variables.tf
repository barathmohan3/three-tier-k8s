variable "aws_region" {}
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