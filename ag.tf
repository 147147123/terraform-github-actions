resource "azurerm_monitor_action_group" "ag_error" {
  name                = "ag-error-${var.environment}-eun"
  short_name          = "ag"
  resource_group_name = azurerm_resource_group.rg-aks.name
  //tags                = local.defaultTags

  dynamic "email_receiver" {
    for_each = var.errorActionGroupMembersList
    content {
      name          = email_receiver.value
      email_address = email_receiver.value
    }
  }
}

resource "azurerm_monitor_action_group" "ag_warning" {
  name                = "ag-warning-${var.environment}-eun"
  short_name          = "ag"
  resource_group_name = data.azurerm_resource_group.resource_group.name
  //tags                = local.defaultTags

  dynamic "email_receiver" {
    for_each = var.warningActionGroupMembersList
    content {
      name          = email_receiver.value
      email_address = email_receiver.value
    }
  }
}

