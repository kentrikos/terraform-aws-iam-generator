# A Terraform set of modules to generate IAM policy documents locally

This modules will generate locally json files with IAM policies.

Policies then needed to be created manually.
For convenience, all policies + text file with description are stored in a single local directory.

## Structure

Module is diveded into 2 useable submodules to be used as `application` and `operations` with additional `common` folder, where shared part is stored.

### application

Is for application account and will generate all necessary policies.

### operations

Is for operations account and will generate all necessary policies.

### common [Internal]

Is handling policies that are same structured for both account types

## Usage

```hcl
module "iam_operations" {
   source = "github.com/kentrikos/terrafrom-aws-iam-generator//opperations"

   transit_aws_account_number      = "1111111111"
   application_aws_account_number  = "2222222222"

   product_domain_name = "pdname"
   environment_type    = "test"
}

module "iam_application" {
   source = "github.com/kentrikos/terrafrom-aws-iam-generator//application"

   transit_aws_account_number      = "1111111111"
   application_aws_account_number  = "2222222222"

   product_domain_name = "pdname"
   environment_type    = "test"
}

```

## Inputs

Inputs are the same for `application` and `operations`.

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| application_aws_account_number | AWS application account number (without hyphens) | string | - | yes |
| auto_IAM_mode | Create IAM Policies in AWS (default false) | string | `false` | no |
| auto_IAM_path | IAM path for auto IAM mode uploaded policies | string | `/` | no |
| environment_type | Type of environment (e.g. test, production) | string | `test` | no |
| k8s_cluster_name_postfix | Domain name of Kubernetes cluster (currently only k8s.local is supported) | string | `k8s.local` | no |
| logs_not_resource | List of resources that log police will NotResource, empty least mean that Resource * is set | list | `<list>` | no |
| operation_aws_account_number | AWS transit account number (without hyphens) | string | - | yes |
| ouputs_directory | Local directory where jsons will be saved | string | `outputs` | no |
| product_domain_name | Name of product domain, will be used to create other names | string | `pdname` | no |
| region | AWS region | string | `eu-central-1` | no |

## Outputs

| Name | Description |
|------|-------------|
| ouputs_directory | Path to directory with jsons |
