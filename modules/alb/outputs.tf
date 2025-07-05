output "alb_dns_name" {
  description = "DNS name of the ALB"
  value       = module.alb_core.this_lb_dns_name
}

output "alb_arn" {
  description = "ARN of the ALB"
  value       = module.alb_core.this_lb_arn
}

output "alb_security_group_id" {
  description = "Security group ID of the ALB"
  value       = module.alb_core.this_security_group_id
}
