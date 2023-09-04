resource "azurerm_resource_group" "rg" {
  name     = "tdupoiron-rg-ghes"
  location = "francecentral"
}

resource "azurerm_resource_group_template_deployment" "ghes" {

  name = "ghes"
  resource_group_name = azurerm_resource_group.rg.name
  deployment_mode = "Incremental"
  template_content = file("ghes_azure_template.json")
  parameters_content = jsonencode({
    "accountPrefix": {
      "value": "tdupoiron"
    },
    "adminUsername": {
      "value": "tdupoiron"
    },
    "vmSize": {
      "value": "Standard_E8s_v3"
    },
    "storageDiskSizeGB": {
      "value": "512"
    },
    "authenticationType": {
      "value": "password"
    },
    "adminPasswordOrKey": {
      "value": "tdup_Admin@2023"
    },
    "location": {
      "value": "northeurope"
    }
  })

}