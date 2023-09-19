variable "resource_group_name" {}
variable "location" {}
variable "appi_name" {}
variable "environment" {}
variable "email_receiver_settings" {
  type = list(object({
    name          = string
    email_address = string
  }))
  default     = []
  description = "List of email receivers"
}