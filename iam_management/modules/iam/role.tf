#Role
resource "aws_iam_role" "role" {

  name = "${var.environment}-${var.context}"
  assume_role_policy = data.aws_iam_policy_document.policy_document.json
}


#Role Policy Attachment
resource "aws_iam_role_policy_attachment" "role_attach" {
  role       = aws_iam_role.role.name
  policy_arn = aws_iam_policy.policy.arn
}