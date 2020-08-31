include {
  path = find_in_parent_folders()
}

terraform {
  source = "git::https://gitlab.com/govtechsingapore/gdsace/terraform-modules/aws-vpc?ref=v1.1.0"
}

inputs = {
  vpc_cidr = "10.101.0.0/16"
  // vpc-0fdfaa149cb6c8482
  eks_cluster_tags = {
    "kubernetes.io/cluster/ryanoolala" = "shared"
  }

  number_of_azs = 3

  public_subnet_new_bits_size = "small"
  private_subnet_new_bits_size = "small"
  database_subnet_new_bits_size = "small"
  # number of subnets to create in each zone is defined by array size
  # You need to make sure you calculate your IP range out prior so as to ensure that you don't have overlapping
  # ip ranges. Use something like github/Terraform-FotD/cidrsubnet for deciding

  public_subnet_net_nums = [1, 2, 3]
  private_subnet_net_nums = [128,129,130,131,132,133,134,135]
  database_subnet_net_nums = [170, 171, 172]
  intranet_subnet_net_nums = [251, 252, 253]


}