resource "aws_vpc" "main" { 
  cidr_block = var.vpc_cidr 
  tags = { 
    Name = var.vpc_name 
  } 
}

resource "aws_internet_gateway" "igw" { 
  vpc_id = aws_vpc.main.id 
  tags = { 
    Name = var.igw_name 
  } 
}


resource "aws_eip" "eip-1" { 
  domain = "vpc" 
  tags = { 
    Name = var.eip_name 
        }
}

resource "aws_subnet" "public1" { 
  vpc_id = aws_vpc.main.id 
  cidr_block = var.public_sub_cidr 
  availability_zone = var.az_1 
  map_public_ip_on_launch = true 
 }

 resource "aws_subnet" "public2" {
  vpc_id = aws_vpc.main.id
  cidr_block = var.public_sub2_cidr
  availability_zone = var.az_2
  map_public_ip_on_launch = true
 }

 
 resource "aws_subnet" "private1" { 
 vpc_id = aws_vpc.main.id 
 cidr_block = var.prisub_cidr 
 availability_zone = var.az_1 
}

resource "aws_nat_gateway" "nat_gw" {
   allocation_id = aws_eip.eip-1.id 
   subnet_id = aws_subnet.public1.id 
}

resource "aws_route_table" "public_rt" { 
  vpc_id = aws_vpc.main.id 
  route { 
    cidr_block = "0.0.0.0/0" 
          gateway_id = aws_internet_gateway.igw.id 
} 
}



resource "aws_route_table" "private_rt" { 
  vpc_id = aws_vpc.main.id 
  route { 
    cidr_block = "0.0.0.0/0" 
    gateway_id = aws_nat_gateway.nat_gw.id 
  } 
  
}

resource "aws_route_table_association" "publicassoc" { 
  subnet_id = aws_subnet.public1.id 
  route_table_id = aws_route_table.public_rt.id 
}

resource "aws_route_table_association" "public2assoc" {
  subnet_id = aws_subnet.public2.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "privateassoc" { 
  subnet_id = aws_subnet.private1.id 
  route_table_id = aws_route_table.private_rt.id 
}


resource "aws_security_group" "main_sg" { 
  vpc_id = aws_vpc.main.id 
  name = "allow ssh" 
  description = "sg for all traffic" 
  ingress { 
    from_port = 0 
        to_port = 0 
        protocol = "-1" 
          cidr_blocks = ["0.0.0.0/0"] 
        } 
  egress { 
    from_port = 0 
          to_port = 0 
          protocol = "-1" 
          cidr_blocks = ["0.0.0.0/0"] 
        }
}