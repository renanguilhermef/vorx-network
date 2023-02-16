resource "aws_vpc" "vorx-vpc-prod" {
    cidr_block = "10.0.0.0/16"

    tags = {
        Name = "Vorx-PROD"
    }
}

resource "aws_subnet" "vorx-subnet-pub-1a"{
    vpc_id = aws_vpc.vorx-vpc-prod.id 
    cidr_block = "10.0.1.0/24"
    availability_zone = "us-east-1a"

    tags = {
        Name = "prod-Public-Subnet-1a"
    }
}

resource "aws_subnet" "vorx-subnet-priv-1a"{
    vpc_id = aws_vpc.vorx-vpc-prod.id 
    cidr_block = "10.0.10.0/24"
    availability_zone = "us-east-1a"

    tags = {
        Name = "prod-Private-Subnet-1a"
    }
}

resource "aws_subnet" "vorx-subnet-pub-1b"{
    vpc_id = aws_vpc.vorx-vpc-prod.id 
    cidr_block = "10.0.2.0/24"
    availability_zone = "us-east-1b"

    tags = {
        Name = "prod-Public-Subnet-1b"
    }
}

resource "aws_subnet" "vorx-subnet-priv-1b"{
    vpc_id = aws_vpc.vorx-vpc-prod.id 
    cidr_block = "10.0.20.0/24"
    availability_zone = "us-east-1b"

    tags = {
        Name = "prod-Private-Subnet-1b"
    }
}

resource "aws_internet_gateway" "igw"{
    vpc_id = aws_vpc.vorx-vpc-prod.id 

    tags = {
        Name = "prod-igw-vorx-vpc"
    }
}

resource "aws_route_table" "public-rt"{
    vpc_id = aws_vpc.vorx-vpc-prod.id 

    route { 
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw.id 
    }
    tags = {
        Name = "prod-public-rt"
    }
}

resource "aws_route_table_association" "pub-rt-1a-associate" {
    subnet_id = aws_subnet.vorx-subnet-pub-1a.id
    route_table_id = aws_route_table.public-rt.id
}

resource "aws_route_table_association" "pub-rt-1b-associate" {
    subnet_id = aws_subnet.vorx-subnet-pub-1b.id
    route_table_id = aws_route_table.public-rt.id
}


## OUTPUTS

output "vpc_vorx_prod_id" {
    value = aws_vpc.vorx-vpc-prod.id
}

output "vpc_vorx_prod_arn" {
    value = aws_vpc.vorx-vpc-prod.arn
}

output "subnet_public_1a_id" {
    value = aws_subnet.vorx-subnet-pub-1a.id
}

output "subnet_private_1a_id" {
    value = aws_subnet.vorx-subnet-priv-1a.id
}

output "subnet_public_1b_id" {
    value = aws_subnet.vorx-subnet-pub-1b.id
}

output "subnet_private_1b_id" {
    value = aws_subnet.vorx-subnet-priv-1b.id
}

output "igw_id" {
    value = aws_internet_gateway.igw.id
}

output "public_route_table_id" {
    value = aws_route_table.public-rt.id
}



