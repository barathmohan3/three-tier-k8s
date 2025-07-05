module "alb_core" {
  source  = "terraform-aws-modules/alb/aws"
  version = "~> 6.0"

  name               = "support-portal-alb"
  load_balancer_type = "application"
  vpc_id             = var.vpc_id
  subnets            = var.public_subnets
  security_groups    = var.security_groups

  target_groups = {
    frontend = {
      backend_protocol = "HTTP"
      backend_port     = 80
    }
    backend = {
      backend_protocol = "HTTP"
      backend_port     = 5000
    }
  }

  tags = var.tags
}
