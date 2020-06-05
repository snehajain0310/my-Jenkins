
# variables.tf

variable "access_key" {
  default = "key"
}
variable "secret_key" {
  default = "key"
}
variable "region" {
  default = "ap-south-1"
}
variable "availability_zone_A" {
  default = "ap-south-1a"
}
variable "key" {
  default = "DevOps"
}
variable "ami" {
  default = "ami-0470e33cd681b2476"
}
variable "instance_type" {
  default = "t2.micro"
}

variable "availabilityZone_A" {
  default = "ap-south-1a"
}
variable "availabilityZone_B" {
  default = "ap-south-1a"
}
variable "availabilityZone_C" {
  default = "ap-south-1a"
}
variable "instanceTenancy" {
  default = "default"
}
variable "dnsSupport" {
  default = true
}
variable "dnsHostNames" {
  default = true
}
variable "vpcCIDRblock" {
  default = "192.168.10.0/24"
}
variable "subnetCIDRblock_A" {
  default = "192.168.10.0/26"
}

variable "subnetCIDRblock_B" {
  default = "192.168.10.64/26"
}

variable "subnetCIDRblock_C" {
  default = "192.168.10.128/26"
}
variable "destinationCIDRblock" {
  default = "0.0.0.0/0"
}
variable "ingressCIDRblock" {
  type    = list
  default = ["0.0.0.0/0"]
}
variable "egressCIDRblock" {
  type    = list
  default = ["0.0.0.0/0"]
}
variable "mapPublicIP" {
  default = true
}

# end of variables.tf
