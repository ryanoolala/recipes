# recipes

A collection of recipes for setting up resources in AWS and EKS

This is my attempt of trying to introduce observability tools to people and providing a recipe for them to add them into their infrastructure as easily as possible, as such you may find that most of these setups may be too simple for your production needs(e.g HA consideration, maintenance processes), and if I am able to think of ways to make these better and able to simplify into recipes, I will update this repository, as a recipe guide for myself in my future setups.

## Requirements

This repository assumes you already have the following tools installed and required IAM permissions(preferable an admin) to use with terraform

1. terraform >= v0.12.29
2. terragrunt >= v0.23.6
3. kubectl >= 1.18
4. helm >= 3.3.0

*Note*

> This is not a free tier compatible setup and any costs incurred will be bared by you and you are responsible for making sure you are allowed to create these paid resources.

## How to use this?

So the way I'm currently structuring this in a way, introducing the recipe based on the amount of time I think it will take you read what it is about, run the command and see the result, I hope the time estimation is accurate for you, but otherwise just see it as a difficulty setting that you want to embark on, and I will describe the differences in the readme of each setup, so that you know what are some of the pros and cons of each method, and why spending more time to incrementally improve the setup is useful.

While there may be faster and even better ways out there using paid SaAS solutions, I'm proposing the open source methods here as a means to get started on the journey of observability, without investing in paid services, and knowing what are the features that you really need, when it comes to integrating into your environment.

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

