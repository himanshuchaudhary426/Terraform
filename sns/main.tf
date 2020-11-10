resource "aws_sns_topic" "user_updates" {
  name   = "user-updates-topic"
  policy = <<EOF
{
  "Version": "2008-10-17",
  "Id": "__default_policy_ID",
  "Statement": [
    {
      "Sid": "__default_statement_ID",
      "Effect": "Allow",
      "Principal": {
        "AWS": "*"
      },
      "Action": [
        "SNS:Publish",
        "SNS:RemovePermission",
        "SNS:SetTopicAttributes",
        "SNS:DeleteTopic",
        "SNS:ListSubscriptionsByTopic",
        "SNS:GetTopicAttributes",
        "SNS:Receive",
        "SNS:AddPermission",
        "SNS:Subscribe"
      ],
      "Resource": "arn:aws:sns:ap-south-1:482204831091:email-topic",
      "Condition": {
        "StringEquals": {
          "AWS:SourceOwner": "482204831091"
        }
      }
    }
  ]
}
EOF

  delivery_policy = <<EOF
{
  "http": {
    "defaultHealthyRetryPolicy": {
      "numRetries": 3,
      "numNoDelayRetries": 0,
      "minDelayTarget": 20,
      "maxDelayTarget": 20,
      "numMinDelayRetries": 0,
      "numMaxDelayRetries": 0,
      "backoffFunction": "linear"
    },
    "disableSubscriptionOverrides": false
  }
}
EOF
}

resource "aws_sns_topic_subscription" "user_updates_sqs_target" {
  topic_arn              = aws_sns_topic.user_updates.arn
  protocol               = "sms"
  endpoint               = "+919837334998"
  endpoint_auto_confirms = true
}
