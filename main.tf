# Root main.tf
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

module "eks" {
  source = "./modules/eks"
  cluster_name    = var.cluster_name
  cluster_version = var.cluster_version
  vpc_id          = module.vpc.vpc_id
  subnets         = module.vpc.private_subnets
  tags            = var.tags
}

module "rds" {
  source = "./modules/rds"
  db_name         = var.db_name
  db_username     = var.db_username
  db_password     = var.db_password
  subnet_ids      = module.vpc.private_subnets
  security_groups = [module.vpc.default_security_group_id]
  tags            = var.tags
}

module "secrets_manager" {
  source = "./modules/secrets_manager"
  db_name     = var.db_name
  db_username = var.db_username
  db_password = var.db_password
  db_host     = module.rds.db_instance_address
  db_port     = 5432
}

module "alb" {
  source = "./modules/alb"
  vpc_id            = module.vpc.vpc_id
  public_subnets    = module.vpc.public_subnets
  security_groups   = [module.vpc.default_security_group_id]
  tags              = var.tags
}


module "ecr" {
  source = "./modules/ecr"
}
