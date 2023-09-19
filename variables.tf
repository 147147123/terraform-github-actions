variable "resource_group_name" {}
variable "location" {}
variable "appi_name" {}
variable "environment" {}
variable "errorActionGroupMembersList" {
  type = list(object({
    name          = string
    email_address = string
  }))
  default     = []
  description = "List of email receivers"
}

variable "warningActionGroupMembersList" {
  type = list(object({
    name          = string
    email_address = string
  }))
  default     = []
  description = "List of email receivers"
}
