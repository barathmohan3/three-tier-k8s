module "alb_core" {
  source  = "terraform-aws-modules/load-balancer/aws"
  version = "~> 2.0"

  name               = "support-portal-alb"
  load_balancer_type = "application"

  vpc_id  = var.vpc_id
  subnets = var.public_subnets

  security_groups = var.security_groups

  target_groups = [
    {
      name_prefix      = "frontend"
      backend_protocol = "HTTP"
      backend_port     = 80
      target_type      = "ip"
      deregistration_delay = 5
    },
    {
      name_prefix      = "backend"
      backend_protocol = "HTTP"
      backend_port     = 5000
      target_type      = "ip"
      deregistration_delay = 5
    }
  ]

  listeners = [
    {
      port     = 80
      protocol = "HTTP"
      default_action = {
        type             = "fixed-response"
        fixed_response   = {
          content_type = "text/plain"
          message_body = "OK"
          status_code  = "200"
        }
      }
    }
  ]

  tags = var.tags
}
