terraform {
  extra_arguments "common" {
    commands = get_terraform_commands_that_need_vars()
    optional_var_files = [
      "${find_in_parent_folders("env.tfvars", "skip-env-if-does-not-exist")}",
      "${find_in_parent_folders("account.tfvars", "skip-account-if-does-not-exist")}",
      "${find_in_parent_folders("common.tfvars", "skip-account-if-does-not-exist")}"
    ]
  }
}

generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite"

  contents = <<EOF
provider "aws" {
  region              = "ap-southeast-1"
}
EOF

}

inputs = {
  aws_region = "ap-southeast-1"
  folder = {
    terraform-folder = "ryan/${path_relative_to_include()}"
  }
  tfstate_global_bucket = "terraform-ryan"
  tfstate_global_bucket_region = "ap-southeast-1"
  vpc_name = "ryanoolala"
}

remote_state {
  backend = "s3"

  generate = {
    path      = "backend.tf"
    if_exists = "overwrite"
  }
  config = {
    bucket         = "terraform-ryan"
    region         = "ap-southeast-1"
    dynamodb_table = "terraform-ryan"
    encrypt        = true

    key = "${path_relative_to_include()}"
  }
}