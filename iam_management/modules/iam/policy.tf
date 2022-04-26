data "aws_iam_policy_document" "policy_document" {

  statement {
    actions = ["sts:AssumeRole"]
    effect  = "Allow"

    principals {
      identifiers = [for user in aws_iam_user.programmatic_user: user.arn]
      type        = "AWS"
    }
  }
}

resource "aws_iam_policy" "policy" {
  name        = "${var.environment}-${var.context}"
  description = "Policy"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Deny",
            "Action": "*",
            "Resource": "*"
        }
    ]
}
EOF
}
