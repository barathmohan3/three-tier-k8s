provider "aws" {
  region = var.aws_region
}

module "vpc" {
  source = "./modules/vpc"
  vpc_cidr        = var.vpc_cidr
  azs             = var.azs
  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets
  tags            = var.tags
}

module "eks_roles" {
  source = "./modules/eks_roles"
  name   = var.cluster_name
}

module "eks" {
  source = "./modules/eks"

  name                        = var.cluster_name
  public_subnets              = module.vpc.public_subnets
  private_subnets             = module.vpc.private_subnets
  cluster_role_arn            = module.eks_roles.cluster_role_arn
  node_role_arn               = module.eks_roles.node_role_arn
  security_group_ids          = [module.vpc.default_security_group_id]
  cluster_role_dependency     = module.eks_roles.dependency
}

module "rds" {
  source           = "./modules/rds"
  db_name          = var.db_name
  db_username      = var.db_username
  db_password      = var.db_password
  subnet_ids       = module.vpc.private_subnets
  tags             = var.tags
}

resource "aws_security_group" "rds_sg" {
  name        = "rds-sg"
  description = "Allow traffic to RDS"
  vpc_id      = module.vpc.vpc_id

  ingress {
    description = "Allow Postgres access"
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # You can restrict to office/public IP
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = var.tags
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

  target_groups = [
  {
    name_prefix      = "fe"
    backend_protocol = "HTTP"
    backend_port     = 80
    target_type      = "ip"
  },
  {
    name_prefix      = "be"
    backend_protocol = "HTTP"
    backend_port     = 5000
    target_type      = "ip"
  }
]


  # Listener with default forward to frontend target group
  http_tcp_listeners = [
    {
      port               = 80
      protocol           = "HTTP"
      target_group_index = 0
    }
  ]

  tags = var.tags
}



module "ecr" {
  source = "./modules/ecr"
}

output "alb_dns_name" {
  description = "DNS name of the ALB"
  value       = module.alb.lb_dns_name
}

output "alb_arn" {
  description = "ARN of the ALB"
  value       = module.alb.lb_arn
}
