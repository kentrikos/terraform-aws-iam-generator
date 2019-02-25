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
