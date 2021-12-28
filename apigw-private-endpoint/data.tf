data "aws_caller_identity" "current" {}

data "external" "lambda_archive" {
  program = ["python3","${path.module}/scripts/build_lambda.py","src_dir", "./python","output_path","./artifacts/lambda.zip","install_dependencies","true"]
}

data "template_file" "policy" {
    template = file("./policy.json")
}

data "aws_vpc_endpoint_service" "test" {
  service = "execute-api"
}

data "aws_security_group" "test" {
  vpc_id = aws_vpc.test.id
  name   = "default"
}

data "aws_availability_zones" "available" {}
