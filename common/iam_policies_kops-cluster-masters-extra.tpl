{
  "Version": "2012-10-17",
  "Statement": [
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
    }
  ]
}
