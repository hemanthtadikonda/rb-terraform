module "vpc" {
  source = "git::https://github.com/hemanthtadikonda/rb-tf-vpc.git"
  env = var.env
  tags = var.tags
  default_vpc_id = var.default_vpc_id
  default_vpc_cidr_block = var.default_vpc_cidr_block
  def_route_table_id =var.def_route_table_id

  for_each = var.vpc

  cidr = each.value["cidr"]
  subnets= each.value ["subnets"]



}

#module "alb" {
#  source = "git::https://github.com/hemanthtadikonda/rb-tf-alb.git"
#  for_each = var.alb
#
#  internal = each.value["internal"]
#  lb_type  = each.value["lb_type"]
#  sg_port  = each.value["sg_port"]
#  sg_ingress_cidr = each.value["sg_ingress_cidr"]
#  vpc_id = local.vpc_id
#
#  default_vpc_id =var.default_vpc_id
#
#}