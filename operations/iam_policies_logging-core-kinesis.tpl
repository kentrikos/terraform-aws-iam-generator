{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "loggingCoreKinesisReadWrite",
      "Effect": "Allow",
      "Action": [
        "kinesis:DescribeStream",
        "kinesis:GetShardIterator",
        "kinesis:GetRecords",
        "kinesis:PutRecord",
        "kinesis:PutRecords"
      ],
      "Resource": [
        "arn:aws:kinesis:${REGION}:${AWS_ACCOUNT_NUMBER}:stream/*"
      ]
    }
  ]
}