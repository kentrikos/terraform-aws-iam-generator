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
