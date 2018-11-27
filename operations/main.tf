# SOME COMMON NAMES:
locals {
  operation_cluster_name         = "${var.product_domain_name}-${var.environment_type}-ops.${var.k8s_cluster_name_postfix}"
  operation_kops_state_s3_bucket = "kops-${var.operation_aws_account_number}-${var.region}-${var.product_domain_name}-${var.environment_type}"
}

##############################################################################
# RENDER AND SAVE CLUSTER POLICIES FOR OPERATION:

module "common_policies" {
  source               = "../common"
  aws_account_number   = "${var.operation_aws_account_number}"
  k8s_cluster_name     = "${local.operation_cluster_name}"
  kops_state_s3_bucket = "${local.operation_kops_state_s3_bucket}"
  logs_not_resource    = "${var.logs_not_resource}"
  region               = "${var.region}"
}

resource "local_file" "iam_policies_kops-cluster-masters-operation" {
  content  = "${module.common_policies.iam_policies_kops-cluster-masters}"
  filename = "${var.ouputs_directory}/operation/masters.${local.operation_cluster_name}.json"
}

resource "local_file" "iam_policies_kops-cluster-masters-extra-operation" {
  content  = "${module.common_policies.iam_policies_kops-cluster-masters-extra}"
  filename = "${var.ouputs_directory}/operation/masters_extra.${local.operation_cluster_name}.json"
}

resource "local_file" "iam_policies_kops-cluster-nodes-operation" {
  content  = "${module.common_policies.iam_policies_kops-cluster-nodes}"
  filename = "${var.ouputs_directory}/operation/nodes.${local.operation_cluster_name}.json"
}

##############################################################################
# SAVE CROSS-ACCOUNT POLICY:
resource "local_file" "AssumeKopsCrossAccount" {
  content  = "${data.aws_iam_policy_document.AssumeKopsCrossAccount.json}"
  filename = "${var.ouputs_directory}/operation/AssumeKopsCrossAccount.json"
}

##############################################################################
# SAVE SIMPLE README:
resource "local_file" "readme" {
  content = <<EOF
# IAM Policy documents for Kubernetes-based environment.

Please create IAM policies on corresponding accounts (default/operation) manually.
For policy names use file names without ".json".
EOF

  filename = "${var.ouputs_directory}/README.md"
}
