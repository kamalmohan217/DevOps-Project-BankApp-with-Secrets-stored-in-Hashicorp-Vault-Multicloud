output "acr_login_server" {
  description = "The URL of the Azure Container Registry"
  value       = azurerm_container_registry.acr.login_server         #azurerm_container_registry.acr.*.login_server
}

output "azure_devopsagent_vm" {
  description = "Private IP Addresses for Azure DevOps Agent VM"
  value       = azurerm_linux_virtual_machine.azure_vm_devopsagent.private_ip_address 
}

output "sas_url_query_string" {
  description = "SAS URL for Azure Storage account container"
  value = "https://${azurerm_storage_account.azure_sa.name}.blob.core.windows.net/${azurerm_storage_container.azure_sa_container.name}${data.azurerm_storage_account_blob_container_sas.container_sas_token.sas}"
}
