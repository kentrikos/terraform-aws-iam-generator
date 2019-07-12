# SOME COMMON NAMES:
locals {
  operations_cluster_name          = "${var.region}-${var.product_domain_name}-${var.environment_type}-ops.${var.k8s_cluster_name_postfix}"
  application_cluster_name         = "${var.region}-${var.product_domain_name}-${var.environment_type}.${var.k8s_cluster_name_postfix}"
  application_kops_state_s3_bucket = "kops-${var.application_aws_account_number}-${var.region}-${var.product_domain_name}-${var.environment_type}"
}

##############################################################################
# RENDER AND SAVE CLUSTER POLICIES FOR APPLICATION:

module "common_policies" {
  source               = "../common"
  aws_account_number   = var.application_aws_account_number
  k8s_cluster_name     = local.application_cluster_name
  kops_state_s3_bucket = local.application_kops_state_s3_bucket
  logs_not_resource    = var.logs_not_resource
  region               = var.region
}

##############################################################################
# RENDER AND SAVE CLUSTER POLICIES FOR APPLICATION:

resource "local_file" "iam_policies_kops-cluster-masters-application" {
  content  = module.common_policies.iam_policies_kops-cluster-masters
  filename = "${var.ouputs_directory}/application/masters.${local.application_cluster_name}.json"
}

resource "local_file" "iam_policies_kops-cluster-masters-extra-application" {
  content  = module.common_policies.iam_policies_kops-cluster-masters-extra
  filename = "${var.ouputs_directory}/application/masters_extra.${local.application_cluster_name}.json"
}

resource "local_file" "iam_policies_kops-cluster-nodes-application" {
  content  = module.common_policies.iam_policies_kops-cluster-nodes
  filename = "${var.ouputs_directory}/application/nodes.${local.application_cluster_name}.json"
}

##############################################################################
# SAVE LOGGING CROSS ACCOUNT POLICIES:
resource "local_file" "allow_cross_account_logging" {
  content  = data.aws_iam_policy_document.allow_cross_account_application_logging.json
  filename = "${var.ouputs_directory}/application/logging_kinesis_cross_account.${local.operations_cluster_name}.json"
}

##############################################################################
# SAVE SIMPLE README:
resource "local_file" "readme" {
  content = <<EOF
# IAM Policy documents for Kubernetes-based environment.

Please create IAM policies on corresponding accounts (advanced/application) manually.
For policy names use file names without ".json".
EOF


  filename = "${var.ouputs_directory}/README.md"
}

##############################################################################
# CREATE IN AWS:
resource "aws_iam_policy" "iam_policies_kops-cluster-masters-application" {
  count = var.auto_IAM_mode
  name = "masters.${local.application_cluster_name}"
  path = var.auto_IAM_path
  policy = module.common_policies.iam_policies_kops-cluster-masters
}

resource "aws_iam_policy" "iam_policies_kops-cluster-masters-extra-application" {
  count = var.auto_IAM_mode
  name = "masters_extra.${local.application_cluster_name}"
  path = var.auto_IAM_path
  policy = module.common_policies.iam_policies_kops-cluster-masters-extra
}

resource "aws_iam_policy" "iam_policies_kops-cluster-nodes-application" {
  count = var.auto_IAM_mode
  name = "nodes.${local.application_cluster_name}"
  path = var.auto_IAM_path
  policy = module.common_policies.iam_policies_kops-cluster-nodes
}

resource "aws_iam_policy" "allow_cross_account_logging" {
  count = var.auto_IAM_mode
  name = "logging_kinesis_cross_account.${local.operations_cluster_name}"
  path = var.auto_IAM_path
  policy = data.aws_iam_policy_document.allow_cross_account_application_logging.json
}

