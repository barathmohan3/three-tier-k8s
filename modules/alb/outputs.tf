output "alb_dns_name" {
  value = module.alb_core.this_lb_dns_name
}

output "alb_arn" {
  value = module.alb_core.this_lb_arn
}

output "alb_security_group_id" {
  value = module.alb_core.this_security_group_id
}
