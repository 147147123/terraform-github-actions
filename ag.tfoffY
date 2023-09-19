resource "azurerm_monitor_action_group" "ag_error" {
  name                = "ag-error-${var.environment}-eun"
  short_name          = "ag"
  resource_group_name = azurerm_resource_group.rg-aks.name
  //tags                = local.defaultTags

  dynamic "email_receiver" {
    for_each = var.errorActionGroupMembersList
    content {
      name          = errorActionGroupMembersList.value["name"]
      email_address = errorActionGroupMembersList.value["email_address"]
    }
  }
}

resource "azurerm_monitor_action_group" "ag_warning" {
  name                = "ag-warning-${var.environment}-eun"
  short_name          = "ag"
  resource_group_name = azurerm_resource_group.rg-aks.name
  //tags                = local.defaultTags

  dynamic "email_receiver" {
    for_each = var.warningActionGroupMembersList
    content {
      name          = warningActionGroupMembersList.value["name"]
      email_address = warningActionGroupMembersList.value["email_address"]
    }
  }
}
