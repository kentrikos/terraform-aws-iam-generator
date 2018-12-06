# POLICY TO ALLOW ASSUMING CROSS-ACCOUNT ROLE ON APPLICATION ACCOUNT:

data "aws_iam_policy_document" "AssumeKopsCrossAccount" {
  statement {
    sid    = "IAMCrossAccountRolePermissions"
    effect = "Allow"

    actions = [
      "sts:AssumeRole",
    ]

    resources = [
      "arn:aws:iam::${var.application_aws_account_number}:role/KopsCrossAccount",
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
      "arn:aws:iam::${var.operations_aws_account_number}:role/*.${local.operation_cluster_name}",
    ]
  }
}
