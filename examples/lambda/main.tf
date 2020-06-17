variable "name" {
  type = string
}

data "aws_iam_policy_document" "assume_role" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "lambda" {
  name                  = var.name
  assume_role_policy    = data.aws_iam_policy_document.assume_role.json
  force_detach_policies = true
}

module "apig_lambda" {

  source = "github.com/comtravo/terraform-aws-lambda?ref=3.0.0"

  file_name     = "./foo.zip"
  function_name = var.name
  handler       = "index.handler"
  role          = aws_iam_role.lambda.arn
  trigger = {
    type = "api-gateway"
  }
  environment = {
    "LOREM" = "IPSUM"
  }
  region = "us-east-1"
  tags = {
    "Foo" : var.name
  }
}

module "apig" {
  source = "../../"

  name       = var.name
  stage      = var.name
  definition = <<EOF
---
swagger: "2.0"
info:
  title: "foo"
schemes:
- "https"
paths:
  /log:
    post:
      consumes:
      - "application/json"
      responses:
        200:
          description: "200 response"
        400:
          description: "400 response"
        403:
          description: "403 response"
      x-amazon-apigateway-integration:
        responses:
          default:
            statusCode: "200"
          400:
            statusCode: "400"
          403:
            statusCode: "403"
        uri: "${module.apig_lambda.invoke_arn}"
        passthroughBehavior: "when_no_match"
        httpMethod: "POST"
        requestTemplates:
          application/json: "{\"auth\":\"$input.params().header.get('Authorization')\"\
            ,\"ticket\":$input.json('ticket_id')
            ,\"save\": \"false\"
            ,\"send\": \"false\"}"
        type: "aws"
EOF
}

output "rest_api_id" {
  value = module.apig.rest_api_id
}

output "deployment_id" {
  value = module.apig.deployment_id
}

output "deployment_invoke_url" {
  value = module.apig.deployment_invoke_url
}

output "deployment_execution_arn" {
  value = module.apig.deployment_execution_arn
}

output "url" {
  value = module.apig.url
}
