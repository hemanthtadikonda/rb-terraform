data "aws_subnets" "main" {
  filter {
    name   = "vpc-id"
    values = [var.default_vpc_id]
  }
}

data "dns_aaaa_record_set" "private_lb_add" {
  host = lookup(lookup(lookup(module.alb , "internal" , null) , "alb" ,null), "dns_name",null)
}