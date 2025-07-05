module "eks" {
  source = "terraform-aws-modules/eks/aws"

  cluster_name    = var.cluster_name
  cluster_version = var.cluster_version
  subnets         = var.subnets
  vpc_id          = var.vpc_id

  eks_managed_node_groups = {
    backend = {
      instance_types = ["t3.medium"]
      min_size       = 1
      max_size       = 3
      desired_size   = 2
    }
  }

  fargate_profiles = {
    frontend = {
      selectors = [
        {
          namespace = "frontend"
        }
      ]
    }
  }

  tags = var.tags
}