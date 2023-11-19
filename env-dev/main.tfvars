default_vpc_id         = "vpc-05642ce42b99a7fae"
default_vpc_cidr_block = "172.31.0.0/16"
def_route_table_id     = "rtb-0dbc8b1b5e435955e"
env  = "qa"
tags = {
  organization  = "TCL TECH"
  project_name  = "robot_shop"
  business_unit = "DFS"
  tower         = "AOD-AOM"
}

vpc = {
  main = {
    cidr = "30.0.0.0/16"
    subnets = {
      public = {
        public1 = { cidr = "30.0.0.0/24" , az  = "us-east-1a" }
        public2 = { cidr = "30.0.1.0/24" , az  = "us-east-1b" }
      }
      app = {
        app1 = { cidr = "30.0.2.0/24" , az = "us-east-1a" }
        app2 = { cidr = "30.0.3.0/24" , az = "us-east-1b" }
      }
      db = {
        db1 = { cidr = "30.0.4.0/24" , az = "us-east-1b" }
        db2 = { cidr = "30.0.5.0/24" , az = "us-east-1b" }
      }
    }
  }
}

alb = {
  public = {
    internal = false
    lb_type = "application"
    sg_port = 80
    sg_ingress_cidr = [ "0.0.0.0/0" ]


  }
  internal ={
    internal = true
    lb_type = "application"
    sg_port = 80
    sg_ingress_cidr = [ "172.31.0.0/16" , "30.0.0.0/16" ]

  }
}


docdb= {
  main = {
    pg_family = "docdb4.0"
    engine    = "docdb"
    engine_version = "4.0.0"
    backup_retention_period = 5
    preferred_backup_window  = "07:00-09:00"
    skip_final_snapshot = true
    instance_count = 1
    instance_class = "db.t3.medium"

  }
}
