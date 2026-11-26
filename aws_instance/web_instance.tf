resource "aws_instance" "web_server" {
    ami             =       var.ami_id
    subnet_id       =       aws_subnet.public_subnet.id
    key_name        =       aws_key_pair.my_keypair.id
    instance_type   =       var.webserver_instance_type
    user_data       =       file("d/terraform-project/aws_instance/userdata_script.sh")
    vpc_security_group_ids  =   [
        aws_security_group.webserver_sg.id
    ]

    root_block_device   {

        volume_size     =   var.volume_size
        volume_type     =   var.volume_type

    }

    tags = {

        Name    =   "webserver"
    }

}


