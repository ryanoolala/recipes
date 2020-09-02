# Grafana

We will be using grafana as our main dashboarding tool which comes with many integrations to various backends such as prometheus, cloudwatch etc

To get dashboards configured by the community, visit [Grafana Dashboards](https://grafana.com/grafana/dashboards)

For cloudwatch specific dashbords, https://grafana.com/grafana/dashboards?dataSource=cloudwatch

# Usage

1. Run `make up` in terraform folder to set up AWS resources first, in my case I use terragrunt, you may copy the example to use to fit your setup
2. Run `make install` in k8s to set up k8s resources using helm

Both steps include makefile commands

# 5min setup

This will start a grafana application, with a few dashboards on AWS resources loaded.
In this setup the grafana instance will be stateless, but this also means we cannot make changes to the dashboard and have it persisted across restarts.

Create a `datasource.yaml` with your cloudwatch role ARN and run `make upgrade` to configure cloudwatch as a data source for grafana

```yaml
datasources:
  datasources.yaml:
    apiVersion: 1
    datasources:
      - name: Cloudwatch
        type: cloudwatch
        isDefault: true
        jsonData:
          authType: arn
          assumeRoleArn: "arn:aws:iam::{{ACCOUNT_ID}}:role/grafana-cloudwatch-role-ryan"
          defaultRegion: "ap-southeast-1"
          customMetricsNamespaces: ""
    version: 1
    editable: true
```

## AWS Resources
- Cloudwatch IAM Role for the grafana application to assume through EC2 and EKS node IAM role trust relationship

## Pros
- Stateless
- No additional costs
- Can be scaled horizontally

## Cons
- Cannot make changes using UI (not persisted across restarts)

# 10min setup

This will add a Postgres database backend to use with grafana, adding a database will help us to store settings and allow for better usability and experience.

### Password preparation
In order to not leak our database passwords and stored in plaintext in terraform state, we will use KMS to encrypt our password, and have it decrypted during terraforming for use.

1. Create your database master password in `./10min/terraform/rds-postgres/postgres/master_passwword.txt`
2. Create your database grafana user password in `./10min/terraform/rds-postgres/postgres/role_passwword.txt`
3. Create kms key, using `terragrunt apply` in `./10min/terraform/rds-kms-key` note the kms key name
4. Update `./10min/terraform/rds-postgres/Makefile`, set `KEY_ID="alias/your-kms-key`
5. In `./10min/terraform/rds-postgres` run `make encrypt` and this will generate `master_password.base64` and `role_password.base64`

### Create database

1. In `./10min/terraform/rds-postgres` run `make up` which will call `terragrunt apply` to create our database.

## AWS Resources
- RDS

## Pros
- Saving changes on the UI for real time updates
- Can scale out and make it highly available

## Cons
- Need a reliable database setup or this will be troublesome to maintain