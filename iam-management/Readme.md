# Terraform IAM module

First initialize the project with : `terraform init`

Then go ahead with a plan to see the changes diff: 

`TF_VAR_access_key=$access_key TF_VAR_secret_key=$secret_key terraform plan`

If you're happy with it you can apply

Tip of the day: perform a `read secret_key` in order to not reveal your key in the shell history