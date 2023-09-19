resource "azurerm_monitor_action_group" "ag_error" {
  name                = "ag-${var.environment}-error"
  resource_group_name = azurerm_resource_group.rg-aks.name
  //location            = var.location
  short_name = "ag"
  enabled    = true //Check

  dynamic "email_receiver" {
    for_each = var.email_receiver_settings
    content {
      name                    = email_receiver.value["name"]
      email_address           = email_receiver.value["email_address"]
      use_common_alert_schema = true
    }
  }
}
