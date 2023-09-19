resource "azurerm_monitor_action_group" "ag_error" {
  name                = "NameOfTheActionGroup"
  resource_group_name = azurerm_resource_group.rg-aks.name
  location            = var.location
  short_name          = "ag"
  enabled             = true //Check

  dynamic "email_receiver" {
    for_each = var.email_receiver_settings
    content {
      name                    = email_receiver_settings.value["name"]
      email_address           = email_receiver_settings.value["email_address"]
      use_common_alert_schema = true
    }
  }

}

variable "email_receiver_settings" {
  type = list(object({
    name          = string
    email_address = string
  }))
  default     = []
  description = "List of email receivers"
}
