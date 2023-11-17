module "vpc" {
  source = "git::https://github.com/hemanthtadikonda/rb-tf-vpc.git"
  for_each = var.vpc

  cidr = each.value["cidr"]
  subnets= each.value ["subnets"]
  default_vpc_id = var.default_vpc_id



}
output "subnets" {
  value = module.vpc
}