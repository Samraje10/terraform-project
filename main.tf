terraform {
  required_version = "~>1.16"

  required_providers {

    aws = {
      source  = "hashicorp/aws"
      version = "~>6.5"
    }

  }

}

module "networking" {
  source = "./networking"

}

resource "aws_key_pair" "my_keypair" {

  key_name    = "my_keypair"
  public_key = file("C:/Users/samra/.ssh/id_rsa.pub")

}

