/**
* # Terraform AWS module for API gateway with Swagger spec
*
* ## Introduction
* This is a minimal Terraform module which accepts a AWS + Swagger spec and deploys an AWS API Gateway
*
* ## Usage
* Check [examples](./examples) on how to use this module
*
* ## Authors
*
* Module managed by [Comtravo](https://github.com/comtravo).
*
* License
* -------
*
* MIT Licensed. See [LICENSE](LICENSE) for full details.
*/


resource "aws_api_gateway_rest_api" "api" {
  name        = var.name
  description = "${var.name} API Integration"
  body        = var.definition
}

# Deploy on change
resource "aws_api_gateway_deployment" "api-deployment" {
  rest_api_id = aws_api_gateway_rest_api.api.id

  triggers = {
    redeployment = sha1(jsonencode(aws_api_gateway_rest_api.api.body))
  }
  
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_api_gateway_stage" "stage" {
  stage_name    = var.stage
  rest_api_id   = aws_api_gateway_rest_api.api.id
  deployment_id = aws_api_gateway_deployment.api-deployment.id
}

resource "aws_api_gateway_base_path_mapping" "custom-domain" {
  count       = var.domain_name != "" ? 1 : 0
  api_id      = aws_api_gateway_rest_api.api.id
  stage_name  = var.stage
  domain_name = var.domain_name
  base_path   = aws_api_gateway_rest_api.api.name

  depends_on = [aws_api_gateway_stage.stage]
}

locals {
  url = var.domain_name != "" ? "https://${var.domain_name}/${aws_api_gateway_rest_api.api.name}" : aws_api_gateway_deployment.api-deployment.invoke_url
}

