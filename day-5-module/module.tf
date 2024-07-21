module "aws" {
    source = "../day-2-ec2"
    ami_id= "ami-0ec0e125bb6c6e8ec"
    instance_type = "t2.micro"
    key_name = "key"
  
}