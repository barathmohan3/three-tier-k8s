variable "cluster_name" {}
variable "cluster_version" {}
variable "vpc_id" {}
variable "subnets" { type = list(string) }
variable "tags" { type = map(string) }
variable "vpc_subnet_ids" {
  type = list(string)
}
