#output "acr" {
#  description = "URL of the Azure Container Registry Created"
#  value       = "${module.aks}"
#}

output "acr_azure_loki_vm_private_ip_container_sas_url" {
  description = "URL of the Azure Container Registry Created, Private IP Addresses for Azure VM and Container SAS URL"
  value       = "${module.aks}"
  sensitive = true
}
