provider "aws" {
	region = "ap-south-1"
}

resource "aws_iam_user" "him" {
  name = "him"
}

resource "aws_iam_access_key" "key" {
  user = aws_iam_user.him.name
}

output "aws_iam_smtp_password_v4" {
  value = aws_iam_access_key.key.ses_smtp_password_v4
}

resource "aws_iam_user_policy" "him_policy" {
  name = "him_policy"
  user = aws_iam_user.him.name

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "ec2:Describe*"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}
