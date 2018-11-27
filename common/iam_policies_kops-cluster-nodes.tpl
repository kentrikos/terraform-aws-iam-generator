{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "kopsK8sEC2NodePerms",
      "Effect": "Allow",
      "Action": [
        "ec2:DescribeInstances",
        "ec2:DescribeRegions"
      ],
      "Resource": [
        "*"
      ]
    },
    {
      "Sid": "kopsK8sS3GetListBucket",
      "Effect": "Allow",
      "Action": [
        "s3:GetBucketLocation",
        "s3:ListBucket"
      ],
      "Resource": [
        "arn:aws:s3:::${KOPS_STATE_S3_BUCKET_NAME}"
      ]
    },
    {
      "Sid": "kopsK8sS3NodeBucketSelectiveGet",
      "Effect": "Allow",
      "Action": [
        "s3:Get*"
      ],
      "Resource": [
        "arn:aws:s3:::${KOPS_STATE_S3_BUCKET_NAME}/${CLUSTER_NAME}/addons/*",
        "arn:aws:s3:::${KOPS_STATE_S3_BUCKET_NAME}/${CLUSTER_NAME}/cluster.spec",
        "arn:aws:s3:::${KOPS_STATE_S3_BUCKET_NAME}/${CLUSTER_NAME}/config",
        "arn:aws:s3:::${KOPS_STATE_S3_BUCKET_NAME}/${CLUSTER_NAME}/instancegroup/*",
        "arn:aws:s3:::${KOPS_STATE_S3_BUCKET_NAME}/${CLUSTER_NAME}/pki/issued/*",
        "arn:aws:s3:::${KOPS_STATE_S3_BUCKET_NAME}/${CLUSTER_NAME}/pki/private/kube-proxy/*",
        "arn:aws:s3:::${KOPS_STATE_S3_BUCKET_NAME}/${CLUSTER_NAME}/pki/private/kubelet/*",
        "arn:aws:s3:::${KOPS_STATE_S3_BUCKET_NAME}/${CLUSTER_NAME}/pki/ssh/*",
        "arn:aws:s3:::${KOPS_STATE_S3_BUCKET_NAME}/${CLUSTER_NAME}/secrets/dockerconfig"
      ]
    },
    {
      "Sid": "kopsK8sS3NodeBucketGetCalicoClient",
      "Effect": "Allow",
      "Action": [
        "s3:Get*"
      ],
      "Resource": "arn:aws:s3:::${KOPS_STATE_S3_BUCKET_NAME}/${CLUSTER_NAME}/pki/private/calico-client/*"
    },
    {
      "Sid": "kopsK8sECR",
      "Effect": "Allow",
      "Action": [
        "ecr:GetAuthorizationToken",
        "ecr:BatchCheckLayerAvailability",
        "ecr:GetDownloadUrlForLayer",
        "ecr:GetRepositoryPolicy",
        "ecr:DescribeRepositories",
        "ecr:ListImages",
        "ecr:BatchGetImage"
      ],
      "Resource": [
        "*"
      ]
    },
    {
        "Sid": "kopsCloudWatchLogs1a",
        "Effect": "Allow",
        "Action": "logs:PutLogEvents",
        ${LOGS_RESOURCE}
    },
    {
        "Sid": "kopsCloudWatchLogs1b",
        "Effect": "Deny",
        "Action": "logs:PutLogEvents",
        "NotResource": [
            "arn:aws:logs:${REGION}:${AWS_ACCOUNT_NUMBER}:log-group:${CLUSTER_NAME}:*"
        ]
    },
    {
        "Sid": "kopsCloudWatchLogs2a",
        "Effect": "Allow",
        "Action": [
            "logs:CreateLogStream",
            "logs:DescribeLogGroups",
            "logs:DescribeLogStreams",
            "logs:PutLogEvents"
        ],
        ${LOGS_RESOURCE}
    },
    {
        "Sid": "kopsCloudWatchLogs2b",
        "Effect": "Deny",
        "Action": [
            "logs:CreateLogStream",
            "logs:DescribeLogGroups",
            "logs:DescribeLogStreams",
            "logs:PutLogEvents"
        ],
        "NotResource": [
            "arn:aws:logs:${REGION}:${AWS_ACCOUNT_NUMBER}:log-group:${CLUSTER_NAME}:*"
        ]
    },
    {
        "Sid": "kopsECRRead",
        "Effect": "Allow",
        "Action": [
            "ecr:GetDownloadUrlForLayer",
            "ecr:BatchGetImage",
            "ecr:DescribeImages",
            "ecr:GetAuthorizationToken",
            "ecr:DescribeRepositories",
            "ecr:ListImages",
            "ecr:BatchCheckLayerAvailability",
            "ecr:GetRepositoryPolicy"
        ],
        "Resource": "*"
    },
    {
      "Sid": "kopsSSM",
      "Effect": "Allow",
      "Action": [
        "ssm:Describe*",
        "ssm:Get*",
        "ssm:List*"
      ],
      "Resource": "*"
    }
  ]
}
