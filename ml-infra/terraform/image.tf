data "aws_ami" "amazon" {
  most_recent = true
  owners           = ["amazon"]

filter {
   name   = "name"
   values = ["amzn2-ami-hvm*"]
 }
}


output "sam" {
  value = data.aws_ami.amazon.id
}
