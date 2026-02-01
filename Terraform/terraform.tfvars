aws_cred = {
  accessskey = "AKIAQXNTXN2VPJBY6O6G"
  secreatkey = "zzxa2TtFSZTDu+DsuDPUrW4zGe2GBWJ/+JR3cO0x"
  region     = "ap-south-1"
}
aws_vpc = {
  cidr = "11.0.0.0/16"
  tags = {
    "Name" = "ecommercesecond_vpc"
  }
}
aws_subnet = {
  cidr              = "11.0.1.0/24"
  availability_zone = "ap-south-1a"
  tags = {
    "Name" = "aws_subnet"
  }
}
awsMaster = {
  ami         = "ami-019715e0d74f695be"
  type        = "t2.medium"
  storage     = 20
  storagetype = "gp3"
  tags = {
    "Name" = "master"
  }
}
awsagent = {
  ami         = "ami-019715e0d74f695be"
  type        = "t2.large"
  storage     = 29
  storagetype = "gp3"
  tags = {
    "Name" = "agent"
  }
}
