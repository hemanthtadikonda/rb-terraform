default_vpc_id         = "vpc-05642ce42b99a7fae"
default_vpc_cidr_block = "172.31.0.0/16"
def_route_table_id     = "rtb-0dbc8b1b5e435955e"
env  = "qa"
zone_id = "Z09760323G7SC2VABFTOY"
ssh_ingress_cidr = [ "172.31.94.218/32" ]
az = ["us-east-1a","us-east-1b"]
acm_certificate_arn = "arn:aws:acm:us-east-1:043254050286:certificate/29e55f5c-03b9-4b51-88c3-eb52bf9f0d27"


tags = {
  organization  = "TCL TECH"
  project_name  = "robot_shop"
  business_unit = "DFS"
  tower         = "AOD-AOM"
}

vpc = {
  main = {
    cidr = "10.10.0.0/16"
    subnets = {
      public = {
        public1 = { cidr = "10.10.0.0/24" , az  = "us-east-1a" }
        public2 = { cidr = "10.10.1.0/24" , az  = "us-east-1b" }
      }
      app = {
        app1 = { cidr = "10.10.2.0/24" , az = "us-east-1a" }
        app2 = { cidr = "10.10.3.0/24" , az = "us-east-1b" }
      }
      db = {
        db1 = { cidr = "10.10.4.0/24" , az = "us-east-1a" }
        db2 = { cidr = "10.10.5.0/24" , az = "us-east-1b" }
      }
    }
  }
}

alb = {
  public = {
    internal = false
    lb_type = "application"
    sg_port = 443
    sg_ingress_cidr = [ "0.0.0.0/0" ]


  }
  internal ={
    internal = true
    lb_type = "application"
    sg_port = 80
    sg_ingress_cidr = [ "172.31.0.0/16" , "10.10.0.0/16" ]

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

rds = {
  main = {
    pg_family = "aurora-mysql5.7"
    rds_type  = "mysql"
    rds_port  = 3306
    engine    = "aurora-mysql"
    engine_version = "5.7.mysql_aurora.2.11.3"
    skip_final_snapshot = true
    preferred_backup_window = "07:00-09:00"
    backup_retention_period = 5
    instance_count       = 1
    instance_class       = "db.t3.small"
  }
}

elasticache = {
  main = {
    elasticache_type ="redis"
    pg_family = "redis6.x"
    engine   = "redis"
    engine_version = "6.2"
    db_port = 6379
    node_type = "cache.t3.micro"
    num_cache_nodes = 1

  }
}
rabbitmq = {
  main = {
    instance_type = "t3.micro"
  }
}

app = {
  frontend = {
    app_port  = 80
    lb_priority = 1
    instance_type = "t3.small"
    desired_capacity = 1
    max_size   = 1
    min_size   = 1

  }
  catalogue = {
    app_port  = 8080
    lb_priority = 2
    instance_type = "t3.micro"
    desired_capacity = 1
    max_size   = 1
    min_size   = 1

  }
  user = {
    app_port  = 8080
    lb_priority = 3
    instance_type = "t3.micro"
    desired_capacity = 1
    max_size   = 1
    min_size   = 1

  }
  cart = {
    app_port  = 8080
    lb_priority = 4
    instance_type = "t3.micro"
    desired_capacity = 1
    max_size   = 1
    min_size   = 1

  }
  shipping = {
    app_port  = 8080
    lb_priority = 5
    instance_type = "t3.micro"
    desired_capacity = 1
    max_size   = 1
    min_size   = 1

  }
  payment = {
    app_port  = 8080
    lb_priority = 6
    instance_type = "t3.micro"
    desired_capacity = 1
    max_size   = 1
    min_size   = 1


  }
}
