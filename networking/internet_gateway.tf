resource "aws_internet_gateway" "app_gateway" {
    vpc_id      = aws_vpc.app_vpc.id
    
    tags        = {
        Name = "my_app_gateway"
    }

}