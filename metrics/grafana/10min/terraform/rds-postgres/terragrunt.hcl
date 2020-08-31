include {
  path = find_in_parent_folders()
}

terraform {
  source = "git::https://gitlab.com/govtechsingapore/gdsace/terraform-modules/rds-postgres?ref=1.0.7"

  extra_arguments "common" {
    commands = get_terraform_commands_that_need_vars()
    optional_var_files = [
      "${get_terragrunt_dir()}/env.tfvars"
    ]
  }
}

inputs = {
  allocated_storage = 10
  database_name = "grafana"
  engine = "postgres"
  instance_class = "db.t2.medium"
  option_group = "9.6"
  parameter_group = "postgres9.6"
  performance_insights_enabled = false
  postgres_role_username = "grafana"
  db_subnet_group_name = dependency.vpc.outputs.database_subnet_group

  publicly_accessible = false
  rds_identifier = "grafana-postgres-ryan"
  rds_kms_alias = "ryan-rds-postgres-grafana"
  subnet_ids  =  dependency.vpc.outputs.database_subnets_ids
  vpc_id = dependency.vpc.outputs.vpc_id
  vpc_cidr = dependency.vpc.outputs.vpc_cidr_block
  username = "grafanaAdmin"

  password_file_path = "${get_terragrunt_dir()}"
}

dependency "vpc" {
  config_path = "../../../../../infrastructure/vpc"
}

dependency "kms" {
  config_path = "../rds-kms-key"
}