resource "aws_eip" "nat_gateway_eip_ip" {

    tags                = {
        Name            = "nat_gateway_eip"
    }

}

resource "aws_nat_gateway" "app_nat_gateway" {

    subnet_id           =   aws_subnet.public_subnet.id
    allocation_id       =   aws_eip.nat_gateway_eip_ip.id
    tags                =   {
        Name            =   "app_nat_gateway" 
    }
}

