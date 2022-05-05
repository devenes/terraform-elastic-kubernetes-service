provider "aws" {
  profile = "default"   # (Optional) This is the AWS profile name as set in the shared credentials file
  region  = "us-east-1" # (Required) AWS region
}

resource "aws_eks_cluster" "example" {
  name     = "a-cluster"                                      # (Required) Name of the cluster
  role_arn = "arn:aws:iam::123:role/eks-poc-eks-cluster-role" # (Required) ARN of the IAM role that provides permissions for the Kubernetes

  vpc_config {                                                # (Required) Configuration block for the VPC associated with your cluster
    subnet_ids = ["subnet-12345678901", "subnet-12345678901"] # (Required) List of subnet IDs
  }
}

resource "aws_eks_node_group" "a-ng" {
  cluster_name    = "a-cluster"                                        # (Required) Name of the EKS Cluster
  node_group_name = "t3_medium-node_group"                             # (Optional) Name of the EKS Node Group
  node_role_arn   = "arn:aws:iam::123:role/eks-poc-eks-nodegroup-role" # (Required) Amazon Resource Name (ARN) of the IAM Role that provides permissions for the EKS Node Group
  subnet_ids      = ["subnet-12345678901", "subnet-12345678901"]       # (Required) Identifiers of EC2 Subnets to associate with the EKS Node Group
  ami_type        = "AL2_x86_64"                                       # (Optional) Type of Amazon Machine Image (AMI) associated with the EKS Node Group
  instance_types  = ["t3.medium"]                                      # (Optional) List of instance types associated with the EKS Node Group. Default: ["t3.medium"]
  capacity_type   = "ON_DEMAND"                                        # (Optional) Type of capacity associated with the EKS Node Group. Valid values: ON_DEMAND, SPOT
  disk_size       = 20                                                 # (Optional) Disk size in GiB for worker nodes. Default: 20 (GiB)

  scaling_config {   # (Required) Configuration block with scaling settings
    desired_size = 2 # (Required) Desired number of worker nodes
    max_size     = 2 # (Required) Maximum number of worker nodes
    min_size     = 1 # (Required) Minimum number of worker nodes
  }
}
