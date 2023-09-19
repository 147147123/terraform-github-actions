variable "resource_group_name" {}
variable "location" {}
variable "appi_name" {}
variable "environment" {}
variable "errorActionGroupMembersList" {
  type = list(string)
}

variable "warningActionGroupMembersList" {
  type = list(string)
}
