default_vpc_id = "vpc-05642ce42b99a7fae"


vpc = {
  main = {
    cidr = "30.0.0.0/16"
    subnets = {
      public = {
        public1 = {
          cidr = "30.0.0.0/24"
          az   = "us-east-1a"
        }
        public2 = {
          cidr = "30.0.1.0/24"
          az = "us-east-1b"
        }
      }
      app = {
        app1 ={
          cidr = "30.0.2.0/24"
          az = "us-east-1a"
        }
        app2 ={
          cidr = "30.0.3.0/24"
          az = "us-east-1b"
        }
      }
      db = {
        db1 ={
          cidr = "30.0.4.0/24"
          az = "us-east-1b"
        }
        db2 ={
          cidr = "30.0.5.0/24"
          az = "us-east-1b"
        }
      }
    }
  }

}