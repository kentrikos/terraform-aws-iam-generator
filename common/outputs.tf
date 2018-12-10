output "iam_policies_kops-cluster-masters" {
  value = "${data.template_file.iam_policies_kops-cluster-masters.rendered}"
}

output "iam_policies_kops-cluster-masters-extra" {
  value = "${data.template_file.iam_policies_kops-cluster-masters-extra.rendered}"
}

output "iam_policies_kops-cluster-nodes" {
  value = "${data.template_file.iam_policies_kops-cluster-nodes.rendered}"
}

output "iam_policies_logging-core-kinesis" {
  value = "${data.template_file.iam_policies_logging-core-kinesis.rendered}"
}

output "iam_policies_logging-core-lambda" {
  value = "${data.template_file.iam_policies_logging-core-lambda.rendered}"
}
