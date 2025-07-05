module "vpc_core" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 5.0"

  name = "support-portal-vpc"
  cidr = var.vpc_cidr

  azs             = var.azs
  private_subnets = var.private_subnets
  public_subnets  = var.public_subnets

  enable_nat_gateway     = true
  single_nat_gateway     = true
  enable_dns_hostnames   = true
  enable_dns_support     = true

  tags = var.tags
}
