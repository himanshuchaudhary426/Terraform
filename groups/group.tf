provider "aws" {
	region ="ap-south-1"
}

#USER

resource "aws_iam_user" "mukesh" {
	  name = "mukesh"
}
resource "aws_iam_user" "abhishek" {
    name = "abhishek"
}
resource "aws_iam_user" "sakshi" {
    name = "sakshi"
}


#GROUP

resource "aws_iam_group" "sre" {
  name = "sre"
}

#BINDING GROUPS WITH POLICIES

resource "aws_iam_policy_attachment" "admins-attach" {
  name = "admins-attach"
  groups = [aws_iam_group.sre.name]
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}

# ADDING USERS TO GROUPS

resource "aws_iam_group_membership" "admin-users" {
  name = "admin-users"
  users = [
  aws_iam_user.mukesh.name,
  aws_iam_user.abhishek.name,
  aws_iam_user.sakshi.name
  ]
  group = aws_iam_group.sre.name
}