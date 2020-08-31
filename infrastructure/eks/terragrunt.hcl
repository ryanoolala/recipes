include {
  path = find_in_parent_folders()
}

terraform {
  source = "git::https://gitlab.com/govtechsingapore/gdsace/terraform-modules/aws-eks?ref=v4.1.3"

  extra_arguments "common" {
    commands = get_terraform_commands_that_need_vars()
    optional_var_files = [
      "${get_terragrunt_dir()}/env.tfvars"
    ]
  }
}

# Variables to be fed into module
inputs = {
  eks_cluster_name = "ryan"
  cluster_version = "1.15"
  environment = "test"
  private_worker_template_variables = [
    {
      instance_type             = "r5a.large"
      asg_min_size              = "2"
      asg_desired_capacity      = "2"
      asg_max_size              = "3"
      iam_instance_profile_name = "eks-worker-private"
      name                      = "services"
    },
  ]

  cluster_endpoint_public_access = true

  config_output_path = "${get_terragrunt_dir()}/"

  // remote state variables
  artifacts_base_path = get_terragrunt_dir()

  # user and roles
  # references:
  # 1. [aws-iam-authenticator](https://github.com/kubernetes-sigs/aws-iam-authenticator)
  # 2. [awscli configuration](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-configure.html)
  map_users = [
    {
      userarn  = "arn:aws:iam::${get_aws_account_id()}:user/ryan_goh"
      username = "terraformer"
      groups   = ["system:masters"]
    }
  ]

  vpc_state_key = "infrastructure/vpc"
}

dependencies {
  paths = ["../vpc"]
}
