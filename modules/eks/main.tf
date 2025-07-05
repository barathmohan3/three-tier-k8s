module "eks_core" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

  cluster_name    = var.cluster_name
  cluster_version = var.cluster_version
  vpc_id          = var.vpc_id
  subnet_ids      = var.subnet_ids

  eks_managed_node_groups = {
  backend = {
    instance_types = ["t3.medium"]
    min_size       = 1
    max_size       = 3
    desired_size   = 2

    # ✅ THIS FIXES IT
    create_launch_template = true
    launch_template_name   = "backend-launch-template"

    pre_bootstrap_user_data = <<-EOT
      #!/bin/bash
      /etc/eks/bootstrap.sh ${var.cluster_name}
    EOT
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
