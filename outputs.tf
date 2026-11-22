output "cluster_name" {
  description = "Name of the EKS cluster."
  value       = aws_eks_cluster.this.name
}

output "cluster_endpoint" {
  description = "API endpoint of the EKS cluster."
  value       = aws_eks_cluster.this.endpoint
}

output "cluster_oidc_issuer" {
  description = "OIDC issuer URL of the EKS cluster (used for IRSA)."
  value       = aws_eks_cluster.this.identity[0].oidc[0].issuer
}

output "vpc_id" {
  description = "ID of the VPC."
  value       = aws_vpc.this.id
}

output "private_subnet_ids" {
  description = "IDs of the private subnets."
  value       = aws_subnet.private[*].id
}

output "public_subnet_ids" {
  description = "IDs of the public subnets."
  value       = aws_subnet.public[*].id
}

output "node_role_arn" {
  description = "ARN of the managed node group IAM role."
  value       = aws_iam_role.nodes.arn
}

output "app_role_arn" {
  description = "ARN of the example IRSA role for applications."
  value       = aws_iam_role.app.arn
}
