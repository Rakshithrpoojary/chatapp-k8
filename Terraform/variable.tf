variable "aws_cred" {
  type = object({
    accessskey = string,
    secreatkey = string,
    region     = string
  })

}

variable "aws_vpc" {
  type = object({
    cidr = string,
    tags = map(string)
  })

}
variable "aws_subnet" {
  type = object({
    cidr              = string,
    availability_zone = string,
    tags              = map(string)
  })

}
variable "awsMaster" {
  type = object({
    ami         = string,
    type        = string,
    storagetype = string,
    storage     = number,
    tags        = map(string)
  })
}
variable "awsagent" {
  type = object({
    ami         = string,
    type        = string,
    storagetype = string,
    storage     = number,
    tags        = map(string)
  })
}
