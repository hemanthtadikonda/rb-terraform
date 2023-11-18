data "aws_subnets" "main" {
  filter {
    name   = "vpc-id"
    values = [var.default_vpc_id]
  }
}