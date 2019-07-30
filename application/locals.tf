locals {
  auto_IAM_mode = var.auto_IAM_mode || var.auto_IAM_mode == "true" ? 1 : 0
}
