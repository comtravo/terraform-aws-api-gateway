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
