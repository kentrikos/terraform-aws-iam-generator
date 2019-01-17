# POLICY TO ALLOW ASSUMING CROSS-ACCOUNT ROLE ON APPLICATION ACCOUNT:

data "aws_iam_policy_document" "AssumeCrossAccount" {
  statement {
    sid    = "IAMCrossAccountRolePermissions"
    effect = "Allow"

    actions = [
      "sts:AssumeRole",
    ]

    resources = [
      "arn:aws:iam::${var.application_aws_account_number}:role/${var.region}_${var.product_domain_name}_${var.environment_type}_CrossAccount",
    ]
  }
}

data "aws_iam_policy_document" "allow_cross_account_application_logging" {
  statement {
    sid    = "IAMCrossAccountKinesisRole"
    effect = "Allow"

    actions = [
      "sts:AssumeRole",
    ]

    resources = [
      "arn:aws:iam::${var.operations_aws_account_number}:role/*.${local.operations_cluster_name}",
    ]
  }
}
