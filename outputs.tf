output "subnets" {
  value = module.vpc
}

output "vpc_id" {
  value = local.vpc_id
}
output "def-sub" {
  value = data.aws_subnets.main.ids
}

output "app-subnets" {
  value = local.app_subents
}