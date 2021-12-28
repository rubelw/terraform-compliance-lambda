terraform {
  backend "s3" {
    bucket = "<mybucketname>"
    key    = "apigw-private-endpoint/tfstat.tf"
    region = "us-east-1"
  }
}