module "accounts" {
  source = "../modules/azure/terraform-accounts"
  application = {
    aks-app = {
      owners = data.azuread_group.grp-admin.members
    }
  }
  service_principal = {
    /** service_principal for application */
    aks-app = {
      application_id = module.accounts.application.aks-app.application_id
      description    = "service-principal for aks-app"
      owners         = data.azuread_group.grp-admin.members
    }
  }
  service_principal_password = {
    aks-app = {
      service_principal_id = module.accounts.service_principal.aks-app.object_id
      rotation             = time_rotating.rotating["service_principal"].id
    }
  }
  key_vault_secret = {
    aks-app = {
      key_vault_id = data.azurerm_key_vault.key_vault_environment.id
      value        = module.accounts.service_principal_password.aks-app.value
      content_type = local.service_principal.aks-app.description
    }
  }
  tags = {
    service = "service_name"
  }
}
