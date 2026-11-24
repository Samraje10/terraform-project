resource "aws_subnet" "app_private_subnet_1" {
    vpc_id                      = aws_vpc.app_vpc.id
    cidr_block                  = "10.0.1.0/24"
    availability_zone           = data.aws_availability_zones.available.names[0]
    tags                        = {
        Name = "app_private_subnet_1"
    }
}

resource "aws_subnet" "app_private_subnet_2" {
    vpc_id                      = aws_vpc.app_vpc.id
    cidr_block                  = "10.0.2.0/24"
    availability_zone           = data.aws_availability_zones.available.names[1]
    tags                        = {
        Name = "app_private_subnet_2"
    }

}

resource "aws_subnet" "nat_public_subnet" {

    vpc_id                      = aws_vpc.app_vpc.id
    cidr_block                  = "10.0.3.0/24"
    availability_zone           = data.aws_availability_zones.available.names[2]
    tags                        = {
        Name    = "nat_public_subnet"
    }

}