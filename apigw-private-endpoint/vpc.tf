resource "aws_vpc" "test" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = var.tags
}

resource "aws_internet_gateway" "test_env_gw" {
    vpc_id = "${aws_vpc.test.id}"
}

resource "aws_route_table" "route_table" {
    vpc_id = "${aws_vpc.test.id}"
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.test_env_gw.id}"
    }
}

resource "aws_route_table_association" "subnet_assoc" {
    subnet_id = "${aws_subnet.public.id}"
    route_table_id = "${aws_route_table.route_table.id}"
}



resource "aws_subnet" "public" {
  vpc_id            = aws_vpc.test.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "${var.aws_region}a"

  tags = var.tags
}


resource "aws_subnet" "private" {
  vpc_id            = aws_vpc.test.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "${var.aws_region}b"

  tags = var.tags
}



// VPC endpoint
resource "aws_vpc_endpoint" "test" {
  vpc_id              = aws_vpc.test.id
  service_name        = data.aws_vpc_endpoint_service.test.service_name
  vpc_endpoint_type   = "Interface"
  private_dns_enabled = true

  subnet_ids         = [aws_subnet.private.id, aws_subnet.public.id]
  security_group_ids = [data.aws_security_group.test.id]

  tags = var.tags
}