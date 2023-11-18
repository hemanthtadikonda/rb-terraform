locals {
  vpc_id = lookup(module.vpc, "vpc_id",null)
  app_subents = [ for k,v in lookup(lookup(lookup(lookup(module.vpc,"main",null ),"subnets",null),"app",null),"subnets_ids",null) : v.id ]
}