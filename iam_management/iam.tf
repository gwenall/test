module "iam" {
  source           = "./modules/iam"

  environment     = "production"
  context         = "ci"
  users           = ["joe", "jane"]
  account_id      = "123456789012"
  oidc_provider   = "accounts.google.com"
  }