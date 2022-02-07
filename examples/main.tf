module "accounts" {
  source      = "../modules/azure/terraform-accounts"
  application = {
    azuredevops = {
      display_name = "azuredevops"
      owners = data.azuread_group.grp-admin.members
    }
  }
  service_principal = {
    azuredevops = {
      application_id = module.accounts.application.azuredevops.application_id
      description    = format("service-principal for %s", "azuredevops")
      owners = data.azuread_group.grp-admin.members
    }
  }
  service_principal_password = {
    azuredevops = {
      service_principal_id = module.accounts.service_principal.azuredevops.object_id
      rotation             = time_rotating.rotating.service_principal.id
    }
  }
  key_vault_secret = {
    azuredevops = {
      name = "azuredevops"
      key_vault_id = "service-mgmt-kv"
      value        = module.accounts.service_principal_password.azuredevops.value
      content_type = format("application %s", "azuredevops")
      tags         = {
        service = "service_name"
      }
    }
  }
  role_assignment = {
    azuredevops = {
      scope                = data.azurerm_subscription.current.id
      role_definition_name = "Contributor"
      principal_id         = module.accounts.service_principal.azuredevops.object_id
    }
  }
}
