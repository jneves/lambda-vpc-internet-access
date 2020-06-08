/* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/. */

resource "aws_subnet" "lambda_to_nat_1" {
  vpc_id     = var.vpc_id
  cidr_block = var.cidr_lambda_1
  availability_zone = var.az_lambda_1

  tags = {
    Name = "lambda-to-nat-1"
  }
}

resource "aws_subnet" "lambda_to_nat_2" {
  vpc_id     = var.vpc_id
  cidr_block = var.cidr_lambda_2
  availability_zone = var.az_lambda_2

  tags = {
    Name = "lambda-to-nat-2"
  }
}

resource "aws_subnet" "lambda_to_nat_3" {
  vpc_id     = var.vpc_id
  cidr_block = var.cidr_lambda_3
  availability_zone = var.az_lambda_3

  tags = {
    Name = "lambda-to-nat-3"
  }
}

resource "aws_subnet" "nat_to_igw_1" {
  vpc_id     = var.vpc_id
  cidr_block = var.cidr_nat_1
  availability_zone = var.az_nat_1

  tags = {
    Name = "nat-to-igw-1"
  }
}

resource "aws_route_table" "lambda_to_nat" {
  vpc_id = var.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.lambda.id
  }

  tags = {
    Name = "lambda-to-nat"
  }
}

resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.lambda_to_nat_1.id
  route_table_id = aws_route_table.lambda_to_nat.id
}

resource "aws_route_table_association" "b" {
  subnet_id      = aws_subnet.lambda_to_nat_2.id
  route_table_id = aws_route_table.lambda_to_nat.id
}

resource "aws_route_table_association" "c" {
  subnet_id      = aws_subnet.lambda_to_nat_3.id
  route_table_id = aws_route_table.lambda_to_nat.id
}

resource "aws_eip" "lambda_nat_gateway" {
  vpc      = true

  tags = {
    Name = "Lambda NAT gateway"
  }
}

resource "aws_nat_gateway" "lambda" {
  allocation_id = aws_eip.lambda_nat_gateway.id
  subnet_id     = aws_subnet.nat_to_igw_1.id

  tags = {
    Name = "Lambda NAT gateway"
  }
}
