param productId string 
param principalId string

resource storage 'Microsoft.Storage/storageAccounts@2019-06-01' = {
  name: '${productId}st'
  location: resourceGroup().location
  sku: {
    name: 'Standard_LRS'
    tier: 'Standard'
  }
  kind: 'StorageV2'
  properties: {
    accessTier: 'Hot'
  }
}

resource keyVault 'Microsoft.KeyVault/vaults@2019-09-01' = {
  name: '${productId}kv'
  location: resourceGroup().location
  properties: {
    sku: {
      family: 'A'
      name: 'standard'
    }
    tenantId: subscription().tenantId
    accessPolicies: [
        {
          objectId: principalId
          tenantId: subscription().tenantId
          permissions: {
            keys: [
              'get' 
              'list'
              'update'
              'create'
              'import'
              'delete'
              'recover'
              'backup'
              'restore'
            ]
            secrets: [
              'get' 
              'list'
              'set'
              'delete'
              'recover'
              'backup'
              'restore'
            ]
            certificates: [
              'get' 
              'list'
              'update'
              'create'
              'import'
              'delete'
              'recover'
              'backup'
              'restore'
              'managecontacts'
              'manageissuers'
              'getissuers'
              'listissuers'
              'setissuers'
              'deleteissuers'
            ]
          }
        }
      ]
  }    
}

resource logWorkspace 'Microsoft.OperationalInsights/workspaces@2020-03-01-preview' = {
  name: '${productId}log'
  location: resourceGroup().location
  properties: {
    sku: {
      name: 'PerGB2018'
    }
    retentionInDays: 30
  }
}

resource registry 'Microsoft.ContainerRegistry/registries@2020-11-01-preview' = {
  name: '${productId}acr'
  location: resourceGroup().location
  sku: {
    name: 'Basic'
  }
  properties: {
    adminUserEnabled: true
  }
}

resource serverFarm 'microsoft.web/serverFarms@2020-06-01' = {
  name: '${productId}plan'
  location: resourceGroup().location
  sku: {
    name: 'B1'
    tier: 'Basic'
  }
  kind: 'linux'
  properties: {
    targetWorkerSizeId: 0
    targetWorkerCount: 1
    reserved: true
  }
}

resource site 'microsoft.web/sites@2020-06-01' = {
  name: '${productId}01app'
  location: resourceGroup().location
  properties: {
    siteConfig: {
      appSettings: [
        {
          name: 'DOCKER_REGISTRY_SERVER_URL'
          value: 'https://${productId}acr.azurecr.io'
        }
        {
          name: 'DOCKER_REGISTRY_SERVER_USERNAME'
          value: '${productId}acr'
        }
        {
          name: 'DOCKER_REGISTRY_SERVER_PASSWORD'
          value: listCredentials(registry.id, registry.apiVersion).passwords[0].value
        }
        {
          name: 'WEBSITES_ENABLE_APP_SERVICE_STORAGE'
          value: 'false'
        }
      ]
      linuxFxVersion: 'DOCKER|${productId}.azurecr.io/latest'
    }
    serverFarmId: serverFarm.id
  }
}