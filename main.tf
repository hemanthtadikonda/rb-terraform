module "vpc" {
  source = "git::https://github.com/hemanthtadikonda/rb-tf-vpc.git"
  for_each = var.vpc

  cidr = each.value["cidr"]
  subnets= each.value ["subnets"]

  env = var.env
  tags = var.tags
  default_vpc_id = var.default_vpc_id
  default_vpc_cidr_block = var.default_vpc_cidr_block
  def_route_table_id =var.def_route_table_id



}
