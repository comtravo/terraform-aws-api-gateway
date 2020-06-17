# Terraform AWS module for API gateway with Swagger spec

## Introduction  
This is a minimal Terraform module which accepts a AWS + Swagger spec and deploys an AWS API Gateway

## Usage  
Check [examples](./examples) on how to use this module

## Authors

Module managed by [Comtravo](https://github.com/comtravo).

License
-------

MIT Licensed. See [LICENSE](LICENSE) for full details.

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.12 |
| aws | ~> 2.0 |

## Providers

| Name | Version |
|------|---------|
| aws | ~> 2.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| definition | Definition of the API Gateway | `string` | n/a | yes |
| name | Name of the API gateway deployment | `string` | n/a | yes |
| stage | Name of the stage to which deployed | `string` | n/a | yes |
| domain_name | Custom domain name | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| deployment_execution_arn | Deployment execution ARN |
| deployment_id | Deployment id |
| deployment_invoke_url | Deployment invoke url |
| rest_api_id | REST API id |
| url | Serverless invoke url |

