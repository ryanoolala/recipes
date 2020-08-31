include {
  path = find_in_parent_folders()
}

terraform {
  source = "git::https://gitlab.com/govtechsingapore/gdsace/terraform-modules/kms-key?ref=1.0.0"
}

inputs = {
  name = "ryan-rds-postgres-grafana"
  description = "KMS Key for RDS encryption in Ryan's recipes"
}
