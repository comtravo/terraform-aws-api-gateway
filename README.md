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
| terraform | >= 0.13 |
| aws | ~> 3.0 |

## Providers

| Name | Version |
|------|---------|
| aws | ~> 3.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| definition | Definition of the API Gateway | `string` | n/a | yes |
| domain\_name | Custom domain name | `string` | `""` | no |
| name | Name of the API gateway deployment | `string` | n/a | yes |
| stage | Name of the stage to which deployed | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| deployment\_execution\_arn | Deployment execution ARN |
| deployment\_id | Deployment id |
| deployment\_invoke\_url | Deployment invoke url |
| name | API Gateway name |
| rest\_api\_id | REST API id |
| url | Serverless invoke url |
