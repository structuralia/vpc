output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "igw_id" {
    value = aws_internet_gateway.internet_gateway
}

output "subnet_public_ids" {
  description = ""
  value       = [for item in aws_subnet.subnet_public : "${item.id}"]
}

output "subnet_private_app_ids" {
  description = ""
  value       = [for item in aws_subnet.subnet_private_app : "${item.id}"]
}

output "subnet_private_db_ids" {
  description = ""
  value       = [for item in aws_subnet.subnet_private_db : "${item.id}"]
}


# output "PUB_SUB_WEB_A_ID" {
#   value = aws_subnet.pub-sub-web-a.id
# }

# output "PUB_SUB_WEB_B_ID" {
#   value = aws_subnet.pub-sub-web-b.id
# }

# output "PUB_SUB_WEB_C_ID" {
#   value = aws_subnet.pub-sub-web-c.id
# }

# output "PRI_SUB_APP_A_ID" {
#   value = aws_subnet.pri-sub-app-a.id
# }

# output "PRI_SUB_APP_B_ID" {
#   value = aws_subnet.pri-sub-app-b.id
# }

# output "PRI_SUB_APP_C_ID" {
#   value = aws_subnet.pri-sub-app-c.id
# }

# output "PRI_SUB_DB_A_ID" {
#   value = aws_subnet.pri-sub-db-a.id
# }

# output "PRI_SUB_DB_B_ID" {
#   value = aws_subnet.pri-sub-db-b.id
# }

# output "PRI_SUB_DB_C_ID" {
#   value = aws_subnet.pri-sub-db-c.id
# }

