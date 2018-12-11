{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "loggingCoreKinesisRead",
      "Effect": "Allow",
      "Action": [
        "kinesis:GetShardIterator",
        "kinesis:GetRecords",
        "kinesis:DescribeStream",
        "kinesis:ListStreams"
      ],
      "Resource": "arn:aws:kinesis:${REGION}:${AWS_ACCOUNT_NUMBER}:stream/*"
    },
    {
      "Sid": "loggingCoreESWrite",
      "Effect": "Allow",
      "Action": [
        "es:ESHttpPost",
        "es:ESHttpPut"
      ],
      "Resource": "arn:aws:es:${REGION}:${AWS_ACCOUNT_NUMBER}:domain/*"
    },
    {
      "Sid": "loggingCoreCloudWatchLogs",
      "Effect": "Allow",
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents",
        "ec2:CreateNetworkInterface",
        "ec2:DescribeNetworkInterfaces",
        "ec2:DeleteNetworkInterface"
      ],
      ${LOGS_RESOURCE}
    }
  ]
}