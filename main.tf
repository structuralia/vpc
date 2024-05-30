# -----------------------------------------------------------------
# Creación de recursos
# -----------------------------------------------------------------
# aws_vpc - Create a VPC
# aws_subnet - Creación de subnets de la vpc
# aws_internet_gateway - Permite la comunicación entre la VPC e internet
# aws_route_table - Creación tabla de enrutamiento para controlar hacia dónde se dirige el tráfico de la red.
# aws_route_table_association - Asociar la tabla de rutas a una subred de VPC
# aws_nat_gateway - Creación de una puerta de enlace de traducción de direcciones de red (NAT) para permitir que la subred privada acceda a los servicios
# aws_eip - Creación de una  IP elástica (EIP) para las puertas de enlace NAT


# -------------------------
# Creación de la vpc
# -------------------------
resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr
  # https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc#enable_dns_support
  enable_dns_support = true
  # https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc#enable_dns_hostnames
  enable_dns_hostnames = true
  
  tags = {
      "Name" = "${var.env}-vpc",
      "Proyect" = var.project_name
  }
}

# ---------------------------------------------
# Creación subredes públicas
# ---------------------------------------------
resource "aws_subnet" "subnet_public" {
  count             = length(var.subnet_cidr_public)
  
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.subnet_cidr_public[count.index]
  availability_zone = var.availability_zone[count.index]
  
  tags = {
    "Name" = "${var.env}-subnet-public-${count.index + 1}"
  }
}

# resource "aws_subnet" "subnet_public" {
#   for_each = { for index, az_name in var.availability_zone : index => az_name }

#   vpc_id                  = aws_vpc.vpc.id
#   cidr_block              = cidrsubnet(aws_vpc.vpc.cidr_block, 4, (each.key + (length(var.availability_zone) * 0)))
#   availability_zone       = each.value
#   map_public_ip_on_launch = true

#   tags = {
#     Name = "${var.env}-subnet-public-${each.key}"
#   }
# }


# resource "aws_subnet" "pub-sub-web-a" {
#   vpc_id                  = aws_vpc.vpc.id
#   cidr_block              = var.pub_sub_web_a_cidr
#   availability_zone       = data.aws_availability_zones.available_zones.names[0]
#   map_public_ip_on_launch = true

#   tags      = {
#     Name    = "${var.env}-pub-sub-web-a"
#   }
# }
# resource "aws_subnet" "pub-sub-web-b" {
#   vpc_id                  = aws_vpc.vpc.id
#   cidr_block              = var.pub_sub_web_b_cidr
#   availability_zone       = data.aws_availability_zones.available_zones.names[1]
#   map_public_ip_on_launch = true

#   tags      = {
#     Name    = "${var.env}-pub-sub-web-b"
#   }
# }
# resource "aws_subnet" "pub-sub-web-c" {
#   vpc_id                  = aws_vpc.vpc.id
#   cidr_block              = var.pub_sub_web_c_cidr
#   availability_zone       = data.aws_availability_zones.available_zones.names[2]
#   map_public_ip_on_launch = true

#   tags      = {
#     Name    = "${var.env}-pub-sub-web-c"
#   }
# }


# ---------------------------------------------
# Creación subredes privadas app
# ---------------------------------------------
resource "aws_subnet" "subnet_private_app" {
  count             = length(var.subnet_cidr_private_app)
  
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.subnet_cidr_private_app[count.index]
  availability_zone = var.availability_zone[count.index]
  
  tags = {
    "Name" = "${var.env}-subnet-private-app-${count.index + 1}"
  }
}

# resource "aws_subnet" "subnet_private_app" {
#   for_each = { for index, az_name in var.availability_zone : index => az_name }

#   vpc_id            = aws_vpc.vpc.id
#   cidr_block        = cidrsubnet(aws_vpc.vpc.cidr_block, 4, (each.key + (length(var.availability_zone) * 1)))
#   availability_zone = each.value

#   tags = {
#     Name = "${var.env}-subnet-private-app-${each.key}"
#   }
# }

# resource "aws_subnet" "pri-sub-app-a" {
#   vpc_id                   = aws_vpc.vpc.id
#   cidr_block               = var.PRI_SUB_APP_A_CIDR
#   availability_zone        = data.aws_availability_zones.available_zones.names[0]
#   map_public_ip_on_launch  = false

#   tags      = {
#     Name    = "${var.project_name}-pub-sub-app-a"
#   }
# }
# resource "aws_subnet" "pri-sub-app-b" {
#   vpc_id                   = aws_vpc.vpc.id
#   cidr_block               = var.PRI_SUB_APP_B_CIDR
#   availability_zone        = data.aws_availability_zones.available_zones.names[1]
#   map_public_ip_on_launch  = false

#   tags      = {
#     Name    = "${var.project_name}-pub-sub-app-b"
#   }
# }
# resource "aws_subnet" "pri-sub-app-c" {
#   vpc_id                   = aws_vpc.vpc.id
#   cidr_block               = var.PRI_SUB_APP_C_CIDR
#   availability_zone        = data.aws_availability_zones.available_zones.names[2]
#   map_public_ip_on_launch  = false

#   tags      = {
#     Name    = "${var.project_name}-pub-sub-app-c"
#   }
# }


# ---------------------------------------------
# Creación subredes privadas db
# ---------------------------------------------
resource "aws_subnet" "subnet_private_db" {
  count             = length(var.subnet_cidr_private_db)
  
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.subnet_cidr_private_db[count.index]
  availability_zone = var.availability_zone[count.index]
  tags = {
    "Name" = "${var.env}-subnet-private-db-${count.index + 1}"
  }
}

# resource "aws_subnet" "subnet_private_db" {
#   for_each = { for index, az_name in var.availability_zone : index => az_name }

#   vpc_id            = aws_vpc.vpc.id
#   cidr_block        = cidrsubnet(aws_vpc.vpc.cidr_block, 4, (each.key + (length(var.availability_zone) * 2)))
#   availability_zone = each.value

#   tags = {
#     Name = "${var.env}-subnet-private-db-${each.key}"
#   }
# }

# resource "aws_subnet" "pri-sub-db-a" {
#   vpc_id                   = aws_vpc.vpc.id
#   cidr_block               = var.PRI_SUB_DB_A_CIDR
#   availability_zone        = data.aws_availability_zones.available_zones.names[0]
#   map_public_ip_on_launch  = false

#   tags      = {
#     Name    = "${var.project_name}-pub-sub-db-a"
#   }
# }
# resource "aws_subnet" "pri-sub-db-b" {
#   vpc_id                   = aws_vpc.vpc.id
#   cidr_block               = var.PRI_SUB_DB_B_CIDR
#   availability_zone        = data.aws_availability_zones.available_zones.names[1]
#   map_public_ip_on_launch  = false

#   tags      = {
#     Name    = "${var.project_name}-pub-sub-db-b"
#   }
# }
# resource "aws_subnet" "pri-sub-db-c" {
#   vpc_id                   = aws_vpc.vpc.id
#   cidr_block               = var.PRI_SUB_DB_C_CIDR
#   availability_zone        = data.aws_availability_zones.available_zones.names[2]
#   map_public_ip_on_launch  = false

#   tags      = {
#     Name    = "${var.project_name}-pub-sub-db-c"
#   }
# }

# ---------------------------------------------
# Creación internet gateway y adjuntar a la vpc
# ---------------------------------------------
resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "${var.env}-igw"
  }
}

# ----------------------------------------------
# Creación tabla de rutas publicas
# ----------------------------------------------
resource "aws_route_table" "route_table_public" {
  vpc_id       = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gateway.id
  }

  tags       = {
    Name     = "${var.env}-rtb-public"
  }
}

# ------------------------------------------------------
# Asociar subredes publicas a la tabla de rutas publicas
# ------------------------------------------------------
resource "aws_route_table_association" "route_table_association_public" {
  count = length(aws_subnet.subnet_public)

  subnet_id      = aws_subnet.subnet_public[count.index].id
  route_table_id = aws_route_table.route_table_public.id
}

# resource "aws_route_table_association" "pub-sub-web-a_route_table_association" {
#   subnet_id           = aws_subnet.pub-sub-web-a.id
#   route_table_id      = aws_route_table.public_route_table.id
# }
# resource "aws_route_table_association" "pub-sub-web-b_route_table_association" {
#   subnet_id           = aws_subnet.pub-sub-web-b.id
#   route_table_id      = aws_route_table.public_route_table.id
# }
# resource "aws_route_table_association" "pub-sub-web-c_route_table_association" {
#   subnet_id           = aws_subnet.pub-sub-web-c.id
#   route_table_id      = aws_route_table.public_route_table.id
# }


# ----------------------------------------------------
# Creación tabla de rutas privadas
# ----------------------------------------------------
resource "aws_route_table" "route_table_private" {
  count = length(aws_subnet.subnet_private_app)

  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gateway[count.index].id
  }

  tags = {
    Name = "${var.env}-route-table-private-${count.index + 1}"
  }
}

# ------------------------------------------------------------
# Asociar subredes privadas app a la tabla de rutas privadas 
# ------------------------------------------------------------
resource "aws_route_table_association" "route_table_association_private_app" {
  count = length(aws_subnet.subnet_private_app)

  subnet_id      = aws_subnet.subnet_private_app[count.index].id
  route_table_id = aws_route_table.route_table_private[count.index].id
}


# --------------------------------------------------------------
# Asociar subredes privadas db a la tabla de rutas privadas db
# --------------------------------------------------------------
resource "aws_route_table_association" "route_table_association_private_db" {
  count = length(aws_subnet.subnet_private_db)

  subnet_id      = aws_subnet.subnet_private_db[count.index].id
  route_table_id = aws_route_table.route_table_private[count.index].id
}

# --------------------------------------------------------------
# Creación nat_gateway
# --------------------------------------------------------------
resource "aws_nat_gateway" "nat_gateway" {
  count = length(aws_subnet.subnet_public)

  connectivity_type = "public"
  subnet_id         = aws_subnet.subnet_public[count.index].id
  allocation_id     = aws_eip.eip_nat_gateway[count.index].id
  depends_on        = [aws_internet_gateway.internet_gateway]

  tags = {
    Name = "${var.env}-nat-gateway-${count.index + 1}"
  }
}

# --------------------------------------------------------------
# Elastic ips para asociar al nat_gateway
# --------------------------------------------------------------
resource "aws_eip" "eip_nat_gateway" {
  count = length(aws_subnet.subnet_public)

  tags = {
    Name = "${var.env}-nat-gateway-eip-${count.index + 1}"
  }
}