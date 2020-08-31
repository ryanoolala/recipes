include {
  path = "${find_in_parent_folders()}"
}

terraform {
  source = "git::https://gitlab.com/govtechsingapore/gdsace/terraform-modules/grafana-cloudwatch-iam?ref=1.0.0"
}

inputs = {
  allow_role_arn = dependency.eks.outputs.worker_iam_role_arn
  name                 = "ryan"
  #random numbers
}

dependency "eks" {
  config_path = "../../../../../infrastructure/eks"
}