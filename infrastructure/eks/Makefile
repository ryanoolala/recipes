include ../../Makefile

define HELP
# EKS
This creates a managed Kubernetes cluster using AWS's EKS.

# Kubeconfig
The kubeconfig file in this directory can be used to connect
to the EKS via AWS IAM authentication. To use it, you can
use the `--kubeconfig /path/to/this/kubeconfig_ryan`
flag. Or you could manually merge it with your local
kubeconfig which is at `~/.kube/config` by default.

# AWS IAM Authentication
To use the AWS IAM authentication mechanism, you will need
an account.

1. Go to https://console.aws.amazon.com/iam/home?region=ap-southeast-1#/users
2. Create a new user without any access rights/permissions
3. Add the user's `User name` into the `./terragrunt.hcl`
   file under the map_users property

endef
export HELP