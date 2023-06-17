variable "proxmox_host" {
  default = "shazam"
}
variable "template_name" {
  default = "ubuntu-2204-template"
}
variable "nic_name" {
  default = "vmbr0"
}
variable "api_url" {
  default = "http://192.168.1.9:8006/api2/json"
}
#Blank var for use by terraform.tfvars
variable "token_secret" {
}
#Blank var for use by terraform.tfvars
variable "token_id" {
}
