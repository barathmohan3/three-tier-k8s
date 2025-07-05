provider "aws" {
  region = var.aws_region
}

module "vpc" {
  source          = "./modules/vpc"
  vpc_cidr        = var.vpc_cidr
  azs             = var.azs
  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets
  tags            = var.tags
}

module "eks" {
  source           = "./modules/eks"
  cluster_name     = var.cluster_name
  cluster_version  = var.cluster_version
  vpc_id           = module.vpc.vpc_id
  subnet_ids       = module.vpc.private_subnets
  tags             = var.tags
}

module "rds" {
  source           = "./modules/rds"
  db_name          = var.db_name
  db_username      = var.db_username
  db_password      = var.db_password
  subnet_ids       = module.vpc.private_subnets
  security_groups  = [module.vpc.default_security_group_id]
  tags             = var.tags
}

module "secrets_manager" {
  source      = "./modules/secrets_manager"
  db_name     = var.db_name
  db_username = var.db_username
  db_password = var.db_password
  db_host     = module.rds.db_instance_address
  db_port     = 5432
}

module "alb" {
  source  = "terraform-aws-modules/alb/aws"
  version = "6.6.0"

  name               = "support-portal-alb"
  load_balancer_type = "application"

  vpc_id          = module.vpc.vpc_id
  subnets         = module.vpc.public_subnets
  security_groups = [module.vpc.default_security_group_id]

  http_tcp_listeners = [
    {
      port               = 80
      protocol           = "HTTP"
      target_group_index = 0
    }
  ]

  target_groups = [
    {
      name_prefix      = "frontend"
      backend_protocol = "HTTP"
      backend_port     = 80
      target_type      = "ip"
    },
    {
      name_prefix      = "backend"
      backend_protocol = "HTTP"
      backend_port     = 5000
      target_type      = "ip"
    }
  ]

  tags = var.tags
}


module "ecr" {
  source = "./modules/ecr"
}

output "alb_dns_name" {
  value = module.alb.dns_name
}

output "alb_arn" {
  value = module.alb.arn
}

output "alb_security_group_id" {
  value = module.alb.security_group_id
}
