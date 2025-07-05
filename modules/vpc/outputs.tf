output "vpc_id" {
  value = module.vpc_core.vpc_id
}

output "private_subnets" {
  value = module.vpc_core.private_subnets
}

output "public_subnets" {
  value = module.vpc_core.public_subnets
}

output "default_security_group_id" {
  value = module.vpc_core.default_security_group_id
}
