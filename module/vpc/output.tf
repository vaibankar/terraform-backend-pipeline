output "vpc_id" {
  value = aws_vpc.Myvpc.id
}

output "public_subnets_id" {
  value = ["${aws_subnet.public_subnet.*.id}"]
}

output "private_subnets_id" {
  value = ["${aws_subnet.private_subnet.*.id}"]
}

output "internet_gateway_id" {
  value = aws_internet_gateway.ig.id
}

output "nat_gateway_id" {
  value = aws_nat_gateway.nat.id
}

output "default_security_group_ids" {
  value = ["${aws_security_group.default.id}"]
}


output "public_route_table" {
  value = aws_route_table.public.id
}
