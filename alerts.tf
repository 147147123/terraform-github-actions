//lsar-emailable
resource "azurerm_monitor_scheduled_query_rules_alert" "otherServiceError" {
  name                = "pixar-emailable-error-${var.environment}"
  resource_group_name = azurerm_resource_group.rg-aks.name //changed
  location            = var.location                       // how to add Global
  description         = "The alert is indicating that Emailable provider returned exceptional status code"
  enabled             = true
  data_source_id      = azurerm_application_insights.appi.id
  severity            = 1
  frequency           = 5
  time_window         = 5
  throttling          = 5
  query_type          = "ResultCount"
  query               = <<-QUERY
  customEvents
  | where name == "ServiceCallProviderError"
    and customDimensions.Provider == "Emailable"
    and (
    (
      toint(customDimensions.ProviderHttpResponseCode) < 200
      or toint(customDimensions.ProviderHttpResponseCode) > 299
    )
    and
    toint(customDimensions.ProviderHttpResponseCode) !in (408, 249, 504)
  )
  | sort by timestamp asc
  QUERY

  action {
    action_group  = [azurerm_monitor_action_group.ag_error.id]
    email_subject = "[ERROR] Emailable timeout"
  }

  trigger {
    operator  = "GreaterThanOrEqual"
    threshold = 1
  }

  //tags = var.defaultTags
}

resource "azurerm_monitor_scheduled_query_rules_alert" "thirdPartyServiceTimeoutsError" {
  name                = "pixar-emailable-timeout-error-${var.environment}"
  resource_group_name = azurerm_resource_group.rg-aks.name //changed
  location            = var.location
  description         = "The alert is indicating that Emailable provider returned 408 or 249 or 504 status code 3 times in 10 minutes"
  enabled             = true
  data_source_id      = azurerm_application_insights.appi.id
  severity            = 1
  frequency           = 5
  time_window         = 5
  throttling          = 5
  query_type          = "ResultCount"
  query               = <<-QUERY
  customEvents
  | where name == "ServiceCallProviderError"
    and customDimensions.Provider == "Emailable"
    and (
    toint(customDimensions.ProviderHttpResponseCode) in (408, 249, 504)
  )
  | sort by timestamp asc
  QUERY

  action {
    action_group  = [azurerm_monitor_action_group.ag_error.id]
    email_subject = "[ERROR] Emailable timeout"
  }

  trigger {
    operator  = "GreaterThanOrEqual"
    threshold = "3"
  }

  //tags = var.defaultTags
}

resource "azurerm_monitor_scheduled_query_rules_alert" "thirdPartyServiceTimeoutsWarning" {
  name                = "pixar-emailable-timeout-warning-${var.environment}"
  resource_group_name = azurerm_resource_group.rg-aks.name //changed
  location            = var.location
  description         = "The alert is indicating that Emailable provider returned 408 or 249 or 504 status code"
  enabled             = true
  data_source_id      = azurerm_application_insights.appi.id
  severity            = 2
  frequency           = 5
  time_window         = 5
  throttling          = 5
  query_type          = "ResultCount"
  query               = <<-QUERY
  customEvents
  | where name == "ServiceCallProviderError"
    and customDimensions.Provider == "Emailable"
    and (
    toint(customDimensions.ProviderHttpResponseCode) in (408, 249, 504)
  )
  | sort by timestamp asc
  QUERY

  action {
    action_group  = [azurerm_monitor_action_group.ag_warning.id]
    email_subject = "[Warning] Emailable timeout"
  }

  trigger {
    operator  = "GreaterThanOrEqual"
    threshold = "3"
  }

  //tags = var.defaultTags
}
