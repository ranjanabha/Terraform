provider "aws"{
    region="eu-west-2"
}

variable "ports"{
    type=list(number)
    description="Allowable port list"
    default=[80,443]
}

resource "aws_instance" "db_server" {
   ami= "ami-020737107b4baaa50"
   instance_type = "t2.micro"
   tags={
    Name="DB Server"
   }
   security_groups = [aws_security_group.allow_ports.name]
}

resource "aws_instance" "web_server" {
  ami= "ami-020737107b4baaa50"
  instance_type = "t2.micro"
   tags={
    Name="Web Server"
   }
   user_data = file("server-script.sh")
   security_groups = [aws_security_group.allow_ports.name]
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

resource "aws_eip" "fixed_ip"{
    instance = aws_instance.web_server.id
}

output "web_fixed_ip"{
    value="Web server fixed ip is ${aws_eip.fixed_ip.public_ip}"
}

output "db_server_private_ip"{
    value="db serve private ip is ${aws_instance.db_server.private_ip}"
}