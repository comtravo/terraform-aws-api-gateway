# Terraform AWS module for API gateway with Swagger spec

## Introduction  
This is a minimal Terraform module which accepts a AWS + Swagger spec and deploys an AWS API Gateway

## Usage

```hcl
data "template_file" "googlemaps-definition" {
  template = "${file("${path.module}/templates/apig/google_maps.tpl")}"

  vars {
    environment = "foo"
  }
}

module "googlemaps" {
  source = "github.com/comtravo/terraform-aws-api-gateway"

  name        = "googlemaps"
  stage       = "foo"
  definition  = "${data.template_file.googlemaps-definition.rendered}"
  domain_name = "${var.production_env ? "foo.bar.com" : "foo.baz.com"}"
}
```

## Authors

Module managed by [Comtravo](https://github.com/comtravo).

License
-------

MIT Licensed. See LICENSE for full details.

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
| domain\_name | Custom domain name | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| deployment\_execution\_arn | Deployment execution ARN |
| deployment\_id | Deployment id |
| deployment\_invoke\_url | Deployment invoke url |
| rest\_api\_id | REST API id |
| url | Serverless invoke url |

