resource "aws_vpc" "ecommerce_vpc" {
  cidr_block = var.aws_vpc.cidr
  tags       = var.aws_vpc.tags
}


resource "aws_subnet" "ecommerce_subnet" {
  vpc_id                  = aws_vpc.ecommerce_vpc.id
  availability_zone       = var.aws_subnet.availability_zone
  cidr_block              = var.aws_subnet.cidr
  map_public_ip_on_launch = true
  tags                    = merge(var.aws_subnet.tags, { "Type" = "Public" })
}

resource "aws_route_table" "aws_rt" {
  vpc_id = aws_vpc.ecommerce_vpc.id
  tags = {
    Name = "ecommercesecondrt"
  }
}
resource "aws_internet_gateway" "aws_igw" {
  vpc_id = aws_vpc.ecommerce_vpc.id
  tags = {
    Name = "igw"
  }
}

resource "aws_route" "aws_rt_igw" {
  route_table_id         = aws_route_table.aws_rt.id
  gateway_id             = aws_internet_gateway.aws_igw.id
  destination_cidr_block = "0.0.0.0/0"
}

resource "aws_route_table_association" "rt_assoc" {
  route_table_id = aws_route_table.aws_rt.id
  subnet_id      = aws_subnet.ecommerce_subnet.id
}

resource "aws_security_group" "agentsg" {
  vpc_id = aws_vpc.ecommerce_vpc.id
  ingress {
    description = "app_port"
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "ssh"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "sonar"
    from_port   = 9000
    to_port     = 9000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    description = "outbound"
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    "Name" = "agent_sg"
  }
}

resource "aws_security_group" "mastersg" {
  vpc_id = aws_vpc.ecommerce_vpc.id
  ingress {
    description = "jenkins"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "ssh"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    description = "outbound"
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    "Name" = "Agent"
  }

}
resource "aws_instance" "master" {
  ami                    = var.awsMaster.ami
  instance_type          = var.awsMaster.type
  subnet_id              = aws_subnet.ecommerce_subnet.id
  key_name               = "jenkins-key"
  vpc_security_group_ids = [aws_security_group.mastersg.id]
  root_block_device {
    volume_size = var.awsMaster.storage
    volume_type = var.awsMaster.storagetype
  }
  tags = var.awsMaster.tags
}
resource "aws_instance" "agent" {
  ami                    = var.awsagent.ami
  instance_type          = var.awsagent.type
  subnet_id              = aws_subnet.ecommerce_subnet.id
  key_name               = "jenkins-key"
  vpc_security_group_ids = [aws_security_group.agentsg.id]
  root_block_device {
    volume_size = var.awsagent.storage
    volume_type = var.awsagent.storagetype
  }
  tags = var.awsagent.tags
}
