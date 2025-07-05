output "cluster_role_arn" {
  value = aws_iam_role.eks_cluster_role.arn
}

output "node_role_arn" {
  value = aws_iam_role.eks_node_role.arn
}

output "dependency" {
  value = [aws_iam_role.cluster_role, aws_iam_role.node_role]
}
