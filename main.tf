#-------------------------------------------------------------------------
# Create vpc with Subnets, RouteTable, IGW, SecurityGroup & Ec2 instances
#-------------------------------------------------------------------------


#-------------------------------------------------------------------------
# # create the VPC
#-------------------------------------------------------------------------

resource "aws_vpc" "My_VPC" {
  cidr_block           = var.vpcCIDRblock
  instance_tenancy     = var.instanceTenancy
  enable_dns_support   = var.dnsSupport
  enable_dns_hostnames = var.dnsHostNames

  tags = {
    Name = "My_VPC"
  }
}

#-------------------------------------------------------------------------
# # create the Subnet A
#-------------------------------------------------------------------------

resource "aws_subnet" "My_VPC_Subnet_A" {
  vpc_id                  = aws_vpc.My_VPC.id
  cidr_block              = var.subnetCIDRblock_A
  map_public_ip_on_launch = var.mapPublicIP
  availability_zone       = var.availabilityZone_A
  tags = {
    Name = "Subnet_A"
  }
}

#-------------------------------------------------------------------------
# # create the Subnet B
#-------------------------------------------------------------------------

resource "aws_subnet" "My_VPC_Subnet_B" {
  vpc_id                  = aws_vpc.My_VPC.id
  cidr_block              = var.subnetCIDRblock_B
  map_public_ip_on_launch = var.mapPublicIP
  availability_zone       = var.availabilityZone_B
  tags = {
    Name = "Subnet_B"
  }
}

#-------------------------------------------------------------------------
# # create the Subnet C
#-------------------------------------------------------------------------

resource "aws_subnet" "My_VPC_Subnet_C" {
  vpc_id                  = aws_vpc.My_VPC.id
  cidr_block              = var.subnetCIDRblock_C
  map_public_ip_on_launch = var.mapPublicIP
  availability_zone       = var.availabilityZone_C
  tags = {
    Name = "Subnet_C"
  }
}

#-------------------------------------------------------------------------
# # Create the Security Group
#-------------------------------------------------------------------------

resource "aws_security_group" "My_VPC_Security_Group" {
  vpc_id      = aws_vpc.My_VPC.id
  name        = "My VPC Security Group"
  description = "My VPC Security Group"

  # allow ingress of port 22
  ingress {
    cidr_blocks = var.ingressCIDRblock
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
  }

  ingress {
    cidr_blocks = var.ingressCIDRblock
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
  }

  # allow egress of all ports
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name        = "My VPC Security Group"
    Description = "My VPC Security Group"
  }
}

#-------------------------------------------------------------------------
# # Create the Internet Gateway
#-------------------------------------------------------------------------

resource "aws_internet_gateway" "My_VPC_GW" {
  vpc_id = aws_vpc.My_VPC.id
  tags = {
    Name = "My VPC Internet Gateway"
  }
} # end resource

#-------------------------------------------------------------------------
# Route Table
#-------------------------------------------------------------------------
# Create the Route Table
resource "aws_route_table" "My_VPC_route_table" {
  vpc_id = aws_vpc.My_VPC.id
  tags = {
    Name = "My VPC Route Table"
  }
} # end resource

#-------------------------------------------------------------------------
# # Create the Internet Access
#-------------------------------------------------------------------------

resource "aws_route" "My_VPC_internet_access" {
  route_table_id         = aws_route_table.My_VPC_route_table.id
  destination_cidr_block = var.destinationCIDRblock
  gateway_id             = aws_internet_gateway.My_VPC_GW.id
} # end resource

#-------------------------------------------------------------------------
# # # Associate the Route Table with the Subnet
#-------------------------------------------------------------------------

resource "aws_route_table_association" "My_VPC_association_A" {
  subnet_id      = aws_subnet.My_VPC_Subnet_A.id
  route_table_id = aws_route_table.My_VPC_route_table.id
} # end resource# end vpc.tf

resource "aws_route_table_association" "My_VPC_association_B" {
  subnet_id      = aws_subnet.My_VPC_Subnet_B.id
  route_table_id = aws_route_table.My_VPC_route_table.id
} # end resource# end vpc.tf

resource "aws_route_table_association" "My_VPC_association_C" {
  subnet_id      = aws_subnet.My_VPC_Subnet_C.id
  route_table_id = aws_route_table.My_VPC_route_table.id
} # end resource# end vpc.tf

#-------------------------------------------------------------------------
# # Create a Web Server
#-------------------------------------------------------------------------

resource "aws_instance" "webserver" {
  ami           = var.ami
  instance_type = var.instance_type
  key_name      = var.key
  subnet_id     = aws_subnet.My_VPC_Subnet_A.id
  #count = 2
  vpc_security_group_ids = [aws_security_group.My_VPC_Security_Group.id]
  user_data              = file("script.sh")
  tags = {
    Name = "terraform-webserver1"
  }
}

output "public_ip" {
  value       = aws_instance.webserver.public_ip
  description = "The public IP of the web server"
}
