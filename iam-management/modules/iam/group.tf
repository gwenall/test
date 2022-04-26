resource "aws_iam_group" "groot" { # I am Groot!
  name = "groot"
  path = "/users/"
}

resource "aws_iam_group_membership" "groot-team" {
  name = "groot-team"

  users = var.users

  group = aws_iam_group.groot.name
}

resource "aws_iam_group_policy_attachment" "test-attach" {
  group      = aws_iam_group.groot.name
  policy_arn = aws_iam_policy.policy.arn
}