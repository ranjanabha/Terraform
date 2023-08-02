variable "ports"{
    type=list(number)
    description="Allowable port list"
    default=[80,443]
}


resource "aws_security_group" "allow_ports" {
    name="AWS SG"
    description = "This will allow port 80 and 443"

    dynamic ingress{
       for_each=var.ports
       iterator=it
       content {
         to_port = it.value
         from_port=it.value
         protocol="TCP"
         cidr_blocks = ["0.0.0.0/0"]
       }
    }

    dynamic egress{
       for_each=var.ports
       iterator=it
       content {
         to_port = it.value
         from_port=it.value
         protocol="TCP"
         cidr_blocks = ["0.0.0.0/0"]
       }
    }
}

output "sg_name" {
  value=aws_security_group.allow_ports.name
}
