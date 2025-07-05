output "alb_dns" {
  value = module.alb.this_lb_dns_name
}

output "alb_arn" {
  value = module.alb.this_lb_arn
}
