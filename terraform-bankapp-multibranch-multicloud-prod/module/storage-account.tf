resource "azurerm_storage_account" "azure_sa" {
  name                      = "vaultbackup24${var.env}"
  resource_group_name       = azurerm_resource_group.aks_rg.name
  location                  = azurerm_resource_group.aks_rg.location
  account_tier              = "Standard"
  account_replication_type  = "GRS"
  min_tls_version           = "TLS1_2"        ### Default TLS Version is TLS1_2.
  shared_access_key_enabled = true
  https_traffic_only_enabled = true
# allowed_copy_scope        = "AAD"   ### Possible values are AAD and PrivateLink                      
  access_tier               = "Hot"
  public_network_access_enabled = true
  
  routing {
    choice = "MicrosoftRouting"
  }
  
  blob_properties {
    delete_retention_policy {
      days = 7
    }
    container_delete_retention_policy {
      days = 7
    }  
  }

  ### For encryption by default Microsoft-managed keys is used.

  infrastructure_encryption_enabled = false

  tags = {
    environment = var.env
  }
}

resource "azurerm_storage_container" "azure_sa_container" {
  name                  = "dexter"
  storage_account_id    = azurerm_storage_account.azure_sa.id
  container_access_type = "private"
}

data "azurerm_storage_account_blob_container_sas" "container_sas_token" {
  connection_string = azurerm_storage_account.azure_sa.primary_connection_string
  container_name    = azurerm_storage_container.azure_sa_container.name
  https_only        = true

  start  = "2025-03-21"
  expiry = "2029-03-21"

  permissions {
    read   = true
    add    = true
    create = false
    write  = true
    delete = false
    list   = true
  }

}
