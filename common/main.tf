# SOME COMMON NAMES:
locals {
  logs_resource = "${length(var.logs_not_resource) != 0 ? "\"NotResource\": ${jsonencode(var.logs_not_resource)}" : "\"Resource\": [\"*\"]"}"
}

##############################################################################
# RENDER  POLICIES:
data "template_file" "iam_policies_kops-cluster-masters" {
  template = "${file("${path.module}/iam_policies_kops-cluster-masters.tpl")}"

  vars {
    CLUSTER_NAME              = "${var.k8s_cluster_name}"
    KOPS_STATE_S3_BUCKET_NAME = "${var.kops_state_s3_bucket}"
  }
}

data "template_file" "iam_policies_kops-cluster-masters-extra" {
  template = "${file("${path.module}/iam_policies_kops-cluster-masters-extra.tpl")}"

  vars {
    CLUSTER_NAME       = "${var.k8s_cluster_name}"
    AWS_ACCOUNT_NUMBER = "${var.aws_account_number}"
    REGION             = "${var.region}"
    LOGS_RESOURCE      = "${local.logs_resource}"
  }
}

data "template_file" "iam_policies_kops-cluster-nodes" {
  template = "${file("${path.module}/iam_policies_kops-cluster-nodes.tpl")}"

  vars {
    CLUSTER_NAME              = "${var.k8s_cluster_name}"
    KOPS_STATE_S3_BUCKET_NAME = "${var.kops_state_s3_bucket}"
    AWS_ACCOUNT_NUMBER        = "${var.aws_account_number}"
    REGION                    = "${var.region}"
    LOGS_RESOURCE             = "${local.logs_resource}"
  }
}

