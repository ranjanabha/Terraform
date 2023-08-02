variable "web_server_id"{
    type=string
}

resource "aws_eip" "fixed_ip"{
    instance = var.web_server_id
}
