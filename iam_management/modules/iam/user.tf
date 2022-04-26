resource "aws_iam_user" "programmatic_user" {
  for_each =  toset(var.users)
  name = each.value
  path = "/system/"

  tags = merge(
    { Environment = var.environment },
    { EmailAddress = "${each.value}@litecoin.com" }
  )
   
}

resource "aws_iam_access_key" "programmatic_user" {
  for_each =  toset( var.users)
  user = each.value
}
