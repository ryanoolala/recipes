-include ./scripts/Makefile

define HELP_OUTPUT

# ops-aws
This directory implements an IAC repository that brings up the
required infrastructure.

# Useful directories
The `modules` directory contains the infrastructure setup and is
composed of terraform modules.

See the README.md for more information!

endef
export HELP_OUTPUT

help:
	@echo "$${HELP}"
down:
	@terragrunt destroy
init:
	@terragrunt init
output:
	@terragrunt output
plan:
	@terragrunt plan
apply:
	@terragrunt apply
up:
	@terragrunt apply
validate:
	@terragrunt validate