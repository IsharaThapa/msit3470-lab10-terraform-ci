resource "aws_vpc" "main" {
  cidr_block = var.cidr_vpc
  tags = {
    Name    = "${var.name_prefix}-vpc"
    Project = "lab07-terraform"
    Owner   = var.name_prefix
  }
}

resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.cidr_public_subnet
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.name_prefix}-public"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
  tags   = { Name = "${var.name_prefix}-igw" }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = { Name = "${var.name_prefix}-public-rt" }
}

resource "aws_route_table_association" "public_assoc" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}

resource "aws_security_group" "web" {
  name        = "${var.name_prefix}-web-sg"
  description = "Allow HTTP (and optional SSH) with least-privilege"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [var.http_allowed_cidr]
  }

  # Optional SSH ingress if my_ip_cidr provided; if empty, rule is not created
  dynamic "ingress" {
    for_each = var.my_ip_cidr != "" ? [1] : []
    content {
      description = "SSH from my IP"
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = [var.my_ip_cidr]
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.name_prefix}-web-sg"
  }
}
# resource "aws_instance" "web" {
#   ami                    = data.aws_ami.amazon_linux.id
#   key_name                = "lab-07"
#   instance_type           = "t2.micro"
#   subnet_id               = aws_subnet.public.id
#   vpc_security_group_ids  = [aws_security_group.web.id]
#   user_data               = file("${path.module}/user_data.sh")
#   tags = {
#     Name = "${var.name_prefix}-web"
#   }
# }

