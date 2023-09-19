# Sample values
resource_group_name = "rg-terraform-github-actions1"
location            = "eastus"
appi_name           = "appi_alert_check"
environment         = "test"
email_receiver_settings = [
  {
    name          = "sendtodevops1"
    email_address = "lkiryl_yaroshkin@epam.com"
  }
]
