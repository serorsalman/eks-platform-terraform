terraform {
  required_version = ">= 1.5"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"

  default_tags {
    tags = {
      Project     = "eks-platform-demo"
      Environment = "demo"
      ManagedBy   = "terraform"
    }
  }
}

module "platform" {
  source = "../.."

  project_name        = "eks-platform-demo"
  region              = "us-east-1"
  vpc_cidr            = "10.1.0.0/16"
  cluster_version     = "1.30"
  node_instance_types = ["t3.large"]
  node_desired_size   = 2
  node_min_size       = 1
  node_max_size       = 4
}

output "cluster_name" {
  value = module.platform.cluster_name
}

output "cluster_endpoint" {
  value = module.platform.cluster_endpoint
}
