resource "aws_iam_role" "cluster_role" {
  name = "${var.name}-eks-cluster-role"
  assume_role_policy = data.aws_iam_policy_document.cluster_assume_role_policy.json
}

resource "aws_iam_role_policy_attachment" "cluster_attach" {
  role       = aws_iam_role.cluster_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}

resource "aws_iam_role" "node_role" {
  name = "${var.name}-eks-node-role"
  assume_role_policy = data.aws_iam_policy_document.node_assume_role_policy.json
}

resource "aws_iam_role_policy_attachment" "worker_attach" {
  for_each = toset([
    "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy",
    "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly",
    "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  ])
  role       = aws_iam_role.node_role.name
  policy_arn = each.value
}

data "aws_iam_policy_document" "cluster_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["eks.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "node_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}
resource "aws_eks_node_group" "backend" {
  cluster_name    = aws_eks_cluster.eks.name
  node_group_name = "${var.cluster_name}-backend"
  node_role_arn   = var.node_role_arn
  subnet_ids      = var.subnet_ids

  instance_types = ["t3.medium"]

  scaling_config {
    desired_size = 2
    min_size     = 1
    max_size     = 3
  }

  launch_template {
    name = "backend-launch-template"
    version = "$Latest"
  }

  tags = var.tags

  lifecycle {
    create_before_destroy = true
  }

  depends_on = [aws_eks_cluster.eks]
}
resource "aws_eks_fargate_profile" "frontend" {
  cluster_name           = aws_eks_cluster.eks.name
  fargate_profile_name   = "${var.cluster_name}-frontend"
  pod_execution_role_arn = var.node_role_arn # Or use a separate Fargate role

  subnet_ids = var.subnet_ids

  selector {
    namespace = "frontend"
  }

  tags = var.tags

  depends_on = [aws_eks_cluster.eks]
}

output "cluster_role_arn" {
  value = aws_iam_role.cluster_role.arn
}

output "node_role_arn" {
  value = aws_iam_role.node_role.arn
}

output "dependency" {
  value = [aws_iam_role.cluster_role, aws_iam_role.node_role]
}
