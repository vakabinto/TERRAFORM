variable "REGION" {
  default = "us-east-1"
}
variable "ZONE" {
  default = "us-east-1a"
}
variable "AMIS" {
  type = map(any)
  default = {
    us-east-2 = "ami-0ccabb5f82d4c9af5"
    us-east-1 = "ami-08a52ddb321b32a8c"
  }
}
variable "SECURITY_GROUPS" {
  default = {
    us-east-1 = "sg-0400c91492e9785f0"
  }
}
variable "PUB_KEY" {
  default = {
    us-east-2 = "us-1-key"
    us-east-1 = "dove-key"
  }
}
variable "MYIP" {
  default = "192.168.177.178/32"
}
