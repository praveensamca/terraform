resource "aws_key_pair" "deployer" {
  key_name   = "deployer-key"
  public_key = file("/home/praveen.sambath/.ssh/id_rsa.pub")
}
