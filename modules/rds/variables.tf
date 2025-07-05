variable "db_name" {}
variable "db_username" {}
variable "db_password" {}
variable "subnet_ids" { type = list(string) }
variable "tags" { type = map(string) }
variable "security_groups" {
  type    = list(string)
  default = []
}

