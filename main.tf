resource "aws_api_gateway_rest_api" "api" {
  name        = "${var.name}"
  description = "${var.name} API Integration"
  body        = "${var.definition}"
}

# Deploy on change
# https://github.com/hashicorp/terraform/issues/6613
resource "aws_api_gateway_deployment" "api-deployment" {
  rest_api_id = "${aws_api_gateway_rest_api.api.id}"
  stage_name  = ""

  # see bug: https://github.com/terraform-providers/terraform-provider-aws/issues/2918

  variables = {
    "version" = "${md5(var.definition)}"
  }
  depends_on = ["aws_api_gateway_rest_api.api"]
}

resource "aws_api_gateway_stage" "stage" {
  stage_name    = "${var.stage}"
  rest_api_id   = "${aws_api_gateway_rest_api.api.id}"
  deployment_id = "${aws_api_gateway_deployment.api-deployment.id}"
}

resource "aws_api_gateway_base_path_mapping" "custom-domain" {
  count       = "${length(var.domain_name) > 0 ? 1 : 0}"
  api_id      = "${aws_api_gateway_rest_api.api.id}"
  stage_name  = "${var.stage}"
  domain_name = "${var.domain_name}"
  base_path   = "${aws_api_gateway_rest_api.api.name}"

  depends_on = ["aws_api_gateway_stage.stage"]
}
