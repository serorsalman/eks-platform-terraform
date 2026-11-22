variable "project_name" {
  description = "Name prefix applied to all resources."
  type        = string
  default     = "eks-platform"
}

variable "region" {
  description = "AWS region to deploy into."
  type        = string
  default     = "us-east-1"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC."
  type        = string
  default     = "10.0.0.0/16"
}

variable "cluster_version" {
  description = "Kubernetes version for the EKS cluster."
  type        = string
  default     = "1.30"
}

variable "node_instance_types" {
  description = "EC2 instance types for the managed node groups."
  type        = list(string)
  default     = ["t3.large"]
}

variable "node_desired_size" {
  description = "Desired number of nodes per managed node group."
  type        = number
  default     = 2
}

variable "node_min_size" {
  description = "Minimum number of nodes per managed node group."
  type        = number
  default     = 1
}

variable "node_max_size" {
  description = "Maximum number of nodes per managed node group."
  type        = number
  default     = 4
}
