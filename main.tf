module "vpc" {
  source   = "git::https://github.com/hemanthtadikonda/rb-tf-vpc.git"
  for_each = var.vpc

  cidr    = each.value[ "cidr" ]
  subnets = each.value [ "subnets" ]

  env                    = var.env
  tags                   = var.tags
  default_vpc_id         = var.default_vpc_id
  default_vpc_cidr_block = var.default_vpc_cidr_block
  def_route_table_id     = var.def_route_table_id

}

module "alb" {
  source   = "git::https://github.com/hemanthtadikonda/rb-tf-alb.git"
  for_each = var.alb

  internal        = each.value["internal"]
  lb_type         = each.value["lb_type"]
  sg_port         = each.value["sg_port"]
  sg_ingress_cidr = each.value["sg_ingress_cidr"]
  vpc_id          = each.value["internal"] ? local.vpc_id : var.default_vpc_id
  subnets         = each.value["internal"] ? local.app_subnets : data.aws_subnets.main.ids

  env  = var.env
  tags = var.tags


}
#
module "docdb" {
  source = "git::https://github.com/hemanthtadikonda/rb-tf-docdb.git"
  env    = var.env
  tags   = var.tags

  for_each = var.docdb

  subnet_ids              = local.db_subnets
  vpc_id                  = local.vpc_id
  sg_ingress_cidr         = local.app_subnets_cidr
  pg_family               = each.value["pg_family"]
  engine                  = each.value["engine"]
  engine_version          = each.value["engine_version"]
  backup_retention_period = each.value["backup_retention_period"]
  preferred_backup_window = each.value["preferred_backup_window"]
  skip_final_snapshot     = each.value["skip_final_snapshot"]
  instance_count          = each.value ["instance_count"]
  instance_class          = each.value["instance_class"]

}
#
#module "rds" {
#  source = "git::https://github.com/hemanthtadikonda/rb-tf-rds.git"
#
#  env  = var.env
#  tags = var.tags
#
#  for_each        = var.rds
#  vpc_id          = local.vpc_id
#  subnet_ids      = local.db_subnets
#  sg_ingress_cidr = local.app_subnets_cidr
#
#  pg_family               = each.value["pg_family"]
#  rds_type                = each.value["rds_type"]
#  rds_port                = each.value["rds_port"]
#  engine                  = each.value["engine"]
#  engine_version          = each.value["engine_version"]
#  skip_final_snapshot     = each.value["skip_final_snapshot"]
#  preferred_backup_window = each.value["preferred_backup_window"]
#  backup_retention_period = each.value["backup_retention_period"]
#  instance_count          = each.value["instance_count"]
#  instance_class          = each.value["instance_class"]
#
#}
#
#module "elasticache" {
#  source = "git::https://github.com/hemanthtadikonda/rb-tf-elasticache.git"
#
#  env  = var.env
#  tags = var.tags
#
#  for_each        = var.elasticache
#  subnet_ids      = local.db_subnets
#  vpc_id          = local.vpc_id
#  sg_ingress_cidr = local.app_subnets_cidr
#
#  elasticache_type = each.value["elasticache_type"]
#  pg_family        = each.value["pg_family"]
#  engine           = each.value["engine"]
#  engine_version   = each.value["engine_version"]
#  db_port          = each.value["db_port"]
#  node_type        = each.value["node_type"]
#  num_cache_nodes  = each.value["num_cache_nodes"]
#
#}
#
#module "rabbitmq" {
#  source = "git::https://github.com/hemanthtadikonda/rb-tf-rabbitmq.git"
#  for_each = var.rabbitmq
#  env = var.env
#  tags = var.tags
#  vpc_id = local.vpc_id
#  subnet_id = local.db_subnets
#  sg_ingress_cidr = local.app_subnets_cidr
#  zone_id   = var.zone_id
#  instance_type = each.value["instance_type"]
#  ssh_ingress_cidr = var.ssh_ingress_cidr
#
#
#
#}

module "app" {
  depends_on = [module.docdb]
#  depends_on = [module.alb , module.docdb ,module.elasticache,module.rds ]
  source = "git::https://github.com/hemanthtadikonda/rb-tf-app.git"
  for_each = var.app

  env = var.env
  tags = var.tags
  ssh_ingress_cidr = var.ssh_ingress_cidr
  default_vpc_id = var.default_vpc_id
  zone_id        = var.zone_id
  az             = var.az
  default_vpc_cidr_block =var.default_vpc_cidr_block


  vpc_id = local.vpc_id
  sg_ingress_cidr = local.app_subnets_cidr
  app_subnet_ids  = local.app_subnets

  component  = each.key
  app_port   = each.value["app_port"]
  lb_priority = each.value["lb_priority"]
  desired_capacity = each.value["desired_capacity"]
  max_size     = each.value["max_size"]
  min_size    = each.value["min_size"]
  instance_type  = each.value["instance_type"]

  public_alb_name  = lookup(lookup(lookup(module.alb , "public" , null) , "alb" ,null), "dns_name",null)
  private_alb_name = lookup(lookup(lookup(module.alb , "internal" , null) , "alb" ,null), "dns_name",null)
  public_alb_listener =lookup(lookup(lookup(module.alb , "public" ,null ), "lb_listener" , null) , "arn" , null )
  private_alb_listener = lookup(lookup(lookup(module.alb , "internal" ,null ), "lb_listener" , null) , "arn" , null )
}


























