# my custom vpc
resource "aws_vpc" "my-vpc" {
  cidr_block           = "10.0.0.0/16"
  instance_tenancy     = "default"
  enable_dns_hostnames = true
  tags = {
    Name = "my-vpc"
  }
}

# public subnet in my-vpc
resource "aws_subnet" "public-subnet" {
  availability_zone       = data.aws_availability_zones.available.names[0]
  vpc_id                  = aws_vpc.my-vpc.id
  map_public_ip_on_launch = true
  cidr_block              = "10.0.0.0/20"

  tags = {
    Name = "public-subnet"
  }

}

#private subnet in my-vpc

resource "aws_subnet" "private-subnet1" {
  availability_zone = data.aws_availability_zones.available.names[1]
  vpc_id            = aws_vpc.my-vpc.id
  cidr_block        = "10.0.16.0/20"
  tags = {
    Name = "private-subnet"
  }
}

resource "aws_subnet" "private-subnet2" {
  availability_zone = data.aws_availability_zones.available.names[2]
  vpc_id            = aws_vpc.my-vpc.id
  cidr_block        = "10.0.32.0/20"
  tags = {
    Name = "private-subnet2"
  }
}
# elastic-ip for natg
resource "aws_eip" "nat-ip" {
  tags = {
    Name = "nat-ip"
  }
}

# internet gateway for public access of resources
resource "aws_internet_gateway" "my-igw" {
  vpc_id = aws_vpc.my-vpc.id

  tags = {
    Name = "my-igw"
  }
}

# nat gateway for private instance to connect to the internet

resource "aws_nat_gateway" "my-ngw" {
  allocation_id = aws_eip.nat-ip.id
  subnet_id     = aws_subnet.public-subnet.id

  tags = {
    Name = "my-ngw"
  }
}

# route tables for public subnet
resource "aws_route_table" "public-rt" {
  vpc_id = aws_vpc.my-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my-igw.id
  }

  tags = {
    Name = "public-rt"
  }
}

# route table for private subnet
resource "aws_route_table" "private-rt" {
  vpc_id = aws_vpc.my-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.my-ngw.id
  }

  tags = {
    Name = "private-rt"
  }
}

# public route table association with public subnet

resource "aws_route_table_association" "public-rta" {
  subnet_id      = aws_subnet.public-subnet.id
  route_table_id = aws_route_table.public-rt.id
}

# private route table association with private subnet
resource "aws_route_table_association" "private-rta1" {
  subnet_id      = aws_subnet.private-subnet1.id
  route_table_id = aws_route_table.private-rt.id
}
resource "aws_route_table_association" "private-rta2" {
  subnet_id      = aws_subnet.private-subnet2.id
  route_table_id = aws_route_table.private-rt.id
}

# security group for for public instances
resource "aws_security_group" "public_instance" {
  name        = "public-instance"
  description = "Allow SSH inbound traffic"
  vpc_id      = aws_vpc.my-vpc.id

  ingress {
    description = "SSH from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP from VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "public-instance-sg"
  }
}

# security group for rds mysql database
resource "aws_security_group" "private_instance" {
  name        = "private-instance"
  description = "Allow SSH inbound traffic"
  vpc_id      = aws_vpc.my-vpc.id

  ingress {
    description = "SSH from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.my-vpc.cidr_block]
  }
  ingress {
    description = "mysql connection from ec2-instance"
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.my-vpc.cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "private-instance-sg"
  }
}

resource "aws_db_subnet_group" "db-subnet" {
  name       = "db-subnet"
  subnet_ids = [aws_subnet.private-subnet1.id, aws_subnet.private-subnet2.id]

  tags = {
    Name = "My DB subnet group"
  }
}

# rds mysql database
resource "aws_db_instance" "mysqldb" {
  identifier             = "himanshu426"
  allocated_storage      = 20
  storage_type           = "gp2"
  engine                 = "mysql"
  engine_version         = "5.7"
  instance_class         = "db.t2.micro"
  name                   = "mysqldb"
  username               = "admin"
  password               = "himanshu123"
  parameter_group_name   = "default.mysql5.7"
  apply_immediately      = true
  skip_final_snapshot    = true
  db_subnet_group_name   = aws_db_subnet_group.db-subnet.name
  vpc_security_group_ids = [aws_security_group.private_instance.id]
  tags = {
    Name = "Mysqldb"
  }
}

# public ec2-instance
resource "aws_instance" "public-instance" {
  ami             = "ami-0cda377a1b884a1bc"
  instance_type   = "t2.micro"
  subnet_id       = aws_subnet.public-subnet.id
  security_groups = [aws_security_group.public_instance.id]
  key_name        = "aws"
  user_data       = file("script.sh")

  tags = {
    Name = "public-instance"
  }
}
