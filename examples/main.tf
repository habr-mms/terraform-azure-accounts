module "accounts-key_vault_secret" {
  source           = "../modules/azure/terraform-accounts"
  key_vault_secret = {
    "mysecret" = {
      key_vault_id = data.azurerm_key_vault.key_vault.id
      value        = module.accounts-service_principal_password.service_principal_password["mysecret"].value
      content_type = "sp password"
    }
  }
}

module "accounts-application" {
  source      = "../modules/azure/terraform-accounts"
  application = {
    aks = {}
  }
}

module "accounts-service_principal" {
  source            = "../modules/azure/terraform-accounts"
  service_principal = {
    aks = {
      application_id = module.accounts-application.application.aks.application_id
      description    = "aks service-principal"
    }
  }
}
module "accounts-service_principal_password" {
  source                     = "../modules/azure/terraform-accounts"
  service_principal_password = {
    aks = {
      service_principal_id = module.accounts-service_principal.service_principal.aks.object_id
      rotation             = time_rotating.rotating.aks.id
    }
  }
}

module "accounts-role_assignment" {
  source          = "../modules/azure/terraform-accounts"
  role_assignment = {
    aks = {
      scope                = data.azurerm_container_registry.container_registry.id
      role_definition_name = "acrpull"
      principal_id         = module.accounts-service_principal.service_principal.aks.object_id
    }
  }
}
