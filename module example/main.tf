provider "aws" {
  region="eu-west-2"
}


module "ec2" {
   source="./ec2"
   security_group_name=module.sg.sg_name
}

module "eip"{
    source="./eip"
    web_server_id=module.ec2.web_server_id
}

module "sg" {
  source="./sg"
  ports=[80,443]
}

output "web_ip" {
  value=module.ec2.web_fixed_ip
}

output "db_ip"{
  value=module.ec2.db_server_private_ip
}
