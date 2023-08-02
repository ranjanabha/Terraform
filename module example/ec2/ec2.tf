variable "security_group_name"{
    type=string
}

resource "aws_instance" "db_server" {
   ami= "ami-020737107b4baaa50"
   instance_type = "t2.micro"
   tags={
    Name="DB Server"
   }
   security_groups = [var.security_group_name]
}

resource "aws_instance" "web_server" {
  ami= "ami-020737107b4baaa50"
  instance_type = "t2.micro"
   tags={
    Name="Web Server"
   }
   user_data = file("server-script.sh")
   security_groups = [var.security_group_name]
}

output "web_fixed_ip"{
    value="Web server fixed ip is ${aws_instance.web_server.public_ip}"
}

output "db_server_private_ip"{
    value="db serve private ip is ${aws_instance.db_server.private_ip}"
}

output "web_server_id"{
    value=aws_instance.web_server.id
}
