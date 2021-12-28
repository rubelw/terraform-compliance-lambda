resource "aws_s3_bucket" "lambda_bucket" {
  bucket = "wills-lambda-bucket"
  acl    = "private"
  force_destroy = true
  tags = {
    Name = "wills-lambda-bucket"
  }
}

resource "aws_s3_bucket_object" "object" {
  depends_on = [aws_s3_bucket.lambda_bucket, data.external.lambda_archive]
  bucket     = "wills-lambda-bucket"
  key        = "lambda.zip"
  source     = "${path.root}/artifacts/lambda.zip"

  # The filemd5() function is available in Terraform 0.11.12 and later
  # For Terraform 0.11.11 and earlier, use the md5() function and the file() function:
  # etag = "${md5(file("path/to/file"))}"
  etag = filemd5("${path.root}/artifacts/lambda.zip")
}
