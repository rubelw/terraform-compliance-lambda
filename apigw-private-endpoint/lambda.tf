resource "aws_lambda_function" "lambda" {
  depends_on = [data.external.lambda_archive]
  function_name    = "terraform_lambda_handler"
  s3_bucket        = aws_s3_bucket_object.object.bucket
  s3_key           = aws_s3_bucket_object.object.key

  runtime = "python3.6"
  handler = "lambda_function.lambda_handler"

  source_code_hash = data.external.lambda_archive.result.base64sha256

  role = aws_iam_role.lambda_exec.arn
  vpc_config {
    subnet_ids = [aws_subnet.private.id, aws_subnet.public.id]
    security_group_ids = [data.aws_security_group.test.id]
  }
  timeout          = 600
  memory_size      = 1024
  layers           = ["arn:aws:lambda:us-east-1:553035198032:layer:git:14"]

}

resource "aws_lambda_permission" "apigw_lambda" {
    statement_id = "AllowExecutionFromAPIGateway"
    action = "lambda:InvokeFunction"
    function_name = aws_lambda_function.lambda.arn
    principal = "apigateway.amazonaws.com"
    source_arn = "${aws_api_gateway_rest_api.apiLambda.execution_arn}/*/*"
}