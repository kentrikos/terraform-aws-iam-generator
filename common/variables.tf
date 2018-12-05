variable "region" {
  description = "AWS region"
  default     = "eu-central-1"
}

variable "aws_account_number" {
  description = "AWS account number (without hyphens)"
}

variable "logs_not_resource" {
  description = "List of resources that log police will NotResource, empty least mean that Resource * is set"
  default     = []
  type        = "list"
}

variable "k8s_cluster_name" {
  description = "Name of Kubernetes cluster"
}

variable "kops_state_s3_bucket" {
  description = "Name of KOPS S3 state bucket"
}
