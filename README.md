# eks-platform-terraform

> **Portfolio demonstration project.** This is not affiliated with any employer and contains no employer code or data. It was built to showcase Terraform and Amazon EKS platform skills.

Production-style Terraform for an Amazon EKS platform: a VPC with public and private subnets across two availability zones, an EKS cluster with managed node groups, cluster add-ons, and IAM Roles for Service Accounts (IRSA).

## Architecture

```
VPC 10.0.0.0/16
├── Public subnets (2 AZs) — internet gateway, NAT gateway
├── Private subnets (2 AZs) — worker nodes live here
└── EKS cluster
    ├── Managed node group (t3.large, 1–4 nodes)
    ├── Add-ons: vpc-cni, CoreDNS, kube-proxy, aws-ebs-csi-driver
    └── IRSA: OIDC provider + least-privilege roles for the EBS CSI driver
        and for applications (example read-only role)
```

What this demonstrates:

- VPC design with public/private subnet separation and a shared NAT gateway (a single NAT gateway keeps demo costs down; production clusters normally run one per AZ)
- EKS control plane with API/audit/authenticator logging enabled
- Managed node groups with rolling updates (`max_unavailable = 1`)
- IRSA with a federated OIDC identity provider — no static credentials
- Least-privilege IAM throughout

## Usage

```bash
cd examples/complete
terraform init
terraform plan
terraform apply
```

Connect to the cluster:

```bash
aws eks update-kubeconfig --name eks-platform-demo --region us-east-1
kubectl get nodes
```

> **Cost warning:** applying this configuration creates real AWS resources (EKS control plane, NAT gateway, EC2 nodes, EBS volumes) that cost money. Run `terraform destroy` when you are done with the demo.

## Files

| File | Purpose |
|---|---|
| `main.tf` | VPC, EKS cluster, node groups, add-ons, IRSA |
| `variables.tf` | Inputs (region, CIDR, cluster version, node sizing) |
| `outputs.tf` | Cluster name, endpoint, OIDC issuer, subnet IDs, role ARNs |
| `versions.tf` | Terraform >= 1.5, AWS provider ~> 5.0, TLS provider ~> 4.0 |
| `examples/complete/main.tf` | Full working example that calls this module |

## CI

Every push runs `terraform fmt -check`, `terraform init -backend=false`, `terraform validate`, and a tfsec scan (see `.github/workflows/ci.yml`).
