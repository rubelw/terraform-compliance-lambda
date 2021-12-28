data "aws_iam_policy_document" "apigw" {
  statement {
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }

    actions = ["execute-api:Invoke"]
    resources = ["*"]

  }

  statement {
    effect = "Deny"

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }

    actions = ["execute-api:Invoke"]
    resources = ["*"]

    condition {
      test     = "StringNotEquals"
      variable = "aws:SourceVpc"
      values = [aws_vpc.test.id]
    }
  }
}

resource "aws_api_gateway_rest_api" "apiLambda" {
  name = var.apigw_name

  policy = data.aws_iam_policy_document.apigw.json

  endpoint_configuration {
    types            = ["PRIVATE"]
    vpc_endpoint_ids = [aws_vpc_endpoint.test.id]
  }

  tags = var.tags
}

resource "aws_api_gateway_rest_api_policy" "test" {
    rest_api_id = aws_api_gateway_rest_api.apiLambda.id
    policy = data.aws_iam_policy_document.apigw.json
}


resource "aws_api_gateway_resource" "proxy" {
    rest_api_id = aws_api_gateway_rest_api.apiLambda.id
    parent_id = aws_api_gateway_rest_api.apiLambda.root_resource_id
    path_part = "{proxy+}"
}

resource "aws_api_gateway_method" "proxyMethod" {
  rest_api_id   = aws_api_gateway_rest_api.apiLambda.id
  resource_id   = aws_api_gateway_resource.proxy.id
  http_method   = "ANY"
  authorization = "NONE"
}


resource "aws_api_gateway_integration" "lambda" {
    rest_api_id = aws_api_gateway_rest_api.apiLambda.id
    resource_id = aws_api_gateway_method.proxyMethod.resource_id
    http_method = aws_api_gateway_method.proxyMethod.http_method
    integration_http_method = "POST"
    type = "AWS_PROXY"
    uri = aws_lambda_function.lambda.invoke_arn
}

resource "aws_api_gateway_method" "proxy_root" {
    rest_api_id = aws_api_gateway_rest_api.apiLambda.id
    resource_id = aws_api_gateway_rest_api.apiLambda.root_resource_id
    http_method = "ANY"
    authorization = "NONE"
}

resource "aws_api_gateway_integration" "lambda_root" {
  rest_api_id = aws_api_gateway_rest_api.apiLambda.id
  resource_id = aws_api_gateway_method.proxy_root.resource_id
  http_method = aws_api_gateway_method.proxy_root.http_method
  integration_http_method = "POST"
  type        = "AWS_PROXY"
  uri = aws_lambda_function.lambda.invoke_arn
}


resource "aws_api_gateway_deployment" "deployment" {
  depends_on = [
    aws_api_gateway_integration.lambda,
    aws_api_gateway_integration.lambda_root
  ]
  rest_api_id       = aws_api_gateway_rest_api.apiLambda.id
  stage_name        = "dev"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_api_gateway_stage" "stage" {
  stage_name    = var.stage_name
  rest_api_id   = aws_api_gateway_rest_api.apiLambda.id
  deployment_id = aws_api_gateway_deployment.deployment.id

  tags = var.tags
}