# Internet VPC

resource "aws_vpc" "main" {
    cidr_block = "10.0.0.0/16"
    instance_tenancy = "default"
    enable_dns_support = "true"
    enable_dns_hostnames = "true"
    tags = {
      Name = "${var.project_name}-vpc"
      ManagedBy = "terraform"
    }
  
}

resource "aws_subnet" "main-public-1" {
    vpc_id = aws_vpc.main.id
    cidr_block = "10.0.101.0/24"
    map_public_ip_on_launch = "true"
    availability_zone = "${var.AWS_REGION}-a"
  
}

resource "aws_subnet" "main-public-2" {
    vpc_id = aws_vpc.main.id
    cidr_block = "10.0.102.0/24"
    map_public_ip_on_launch = "true"
    availability_zone = "{var.AWS_REGION}-b"
  
}

resource "aws_subnet" "main-public-3" {
    vpc_id = aws_vpc.main.id
    cidr_block = "10.0.103.0/24"
    map_public_ip_on_launch = "true"
    availability_zone = "${var.AWS_REGION}c"
  
}

resource "aws_subnet" "main-private-1" {
    vpc_id = aws_vpc.main.id
    cidr_block = "10.0.1.0/24"
    map_public_ip_on_launch = "false"
    availability_zone = "${var.AWS_REGION}a"
  
}

resource "aws_subnet" "main-private-2" {
    vpc_id = aws_vpc.main.id
    cidr_block = "10.0.2.0/24"
    map_public_ip_on_launch = "false"
    availability_zone = "{var.AWS_REGION}-b"
  
}

resource "aws_subnet" "main-private-3" {
    vpc_id = aws_vpc.main.id
    cidr_block = "10.0.3.0/24"
    map_public_ip_on_launch = "false"
    availability_zone = "{var.AWS_REGION}-c"
  
}


# internet GW
resource "aws_internet_gateway" "main-gw" {
    vpc_id = aws_vpc.main.id
    tags = {
        Name = "${var.project_name}-main"
        ManagedBy = "terraform"
    }
  
}

# public route table

resource "aws_route_table" "main-public" {
    vpc_id = aws_vpc.main.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.main-gw.id
    }
    tags = {
        Name = "main-public-1"
        ManagedBy = "terraform"
    }

}

resource "aws_route_table_association" "main-public-1a" {
    subnet_id = aws_subnet.main-public-1.id
    route_table_id = aws_route_table.main-public.id
  
}

resource "aws_route_table_association" "main-public-2a" {
    subnet_id = aws_subnet.main-public-2.id
    route_table_id = aws_route_table.main-public.id
  
}

resource "aws_route_table_association" "main-public-3a" {
    subnet_id = aws_subnet.main-public-3.id
    route_table_id = aws_route_table.main-public.id
  
}