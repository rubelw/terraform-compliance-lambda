variable "tags" {
  type        = map(string)
  default     = {}
  description = "Tags to add to resources"
}

variable "stage_name" {
  type        = string
  default     = "test"
  description = "API Gateway Stage Name"
}

variable "apigw_name" {
  type        = string
  default     = "some-api"
  description = "API Gateway Name"
}

variable "aws_region" {
    type = string
    default = "us-east-1"
}

variable "install_dependencies" {
  description = "Whether to install pip dependecies"
  type        = bool
  default     = true
}