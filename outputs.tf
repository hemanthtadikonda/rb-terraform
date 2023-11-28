#output "subnets" {
#  value = module.vpc
#}
#
#output "vpc_id_test" {
#  value = local.vpc_id
#}
#output "def-sub" {
#  value = data.aws_subnets.main.ids
#}
#
#output "app-subnets" {
#  value = local.app_subnets
#}

output "lb_details" {
  value = module.alb
}

output "lb_int_dns" {
  value = lookup(lookup(lookup(module.alb , "internal" , null) , "alb" ,null), "dns_name",null)
}
output "lb_int_listener" {
  value = lookup(lookup(lookup(module.alb , "internal" ,null ), "lb_listener" , null) , "arn" , null )
}

output "lb_pub_dns" {
  value = lookup(lookup(lookup(module.alb , "public" , null) , "alb" ,null), "dns_name",null)
}
output "lb_pub_listener" {
  value = lookup(lookup(lookup(module.alb , "internal" ,null ), "lb_listener" , null) , "arn" , null )
}

output "private_lb_add_details" {
  value = data.dns_aaaa_record_set.private_lb_add.addrs
}