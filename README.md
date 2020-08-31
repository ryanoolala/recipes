# recipes

A collection of recipes for setting up resources in AWS and EKS

## Requirements

This repository assumes you already have the following tools installed and required IAM permissions(preferable an admin) to use with terraform

1. terraform >= v0.12.29
2. terragrunt >= v0.23.6
3. kubectl >= 1.18
4. helm >= 3.3.0

*Note*

> This is not a free tier compatible setup and any costs incurred will be bared by you and you are responsible for making sure you are allowed to create these paid resources.

## Directory setup of this repository

### Infrastructure
The `infrastructure` folder contains the terragrunt files to setting up a basic VPC and EKS cluster in AWS, this is meant for use as an example in which recipes are then applied on.

#### Resources created

- VPC
  - Internet Gateway
  - NAT Gateway
  - subnets (public,private,intranet,database)
  - Route tables
  - Network ACLs
- EKS
  - 1 autoscaling group with 2 ec2 worker nodes

### Metrics

Recipes under the topic of #monitoring #metrics

