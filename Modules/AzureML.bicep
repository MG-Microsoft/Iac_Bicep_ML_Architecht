param location string = resourceGroup().location
param tagValues object
param AzureMLName string
param enableHbiWorkspace bool = false
param storageAccountID string
param keyVaultID string
param applicationInsightsID string
param containerRegistryID string


resource aml 'Microsoft.MachineLearningServices/workspaces@2020-08-01' = {
  name: AzureMLName
  tags: tagValues
  location: location
  identity: {
    type: 'SystemAssigned'
  }
  sku: {
    name: 'Enterprise'
    tier: 'Enterprise'
  }
  properties: {
    friendlyName: AzureMLName
    keyVault: keyVaultID
    storageAccount: storageAccountID
    applicationInsights: applicationInsightsID
    containerRegistry: containerRegistryID
    hbiWorkspace: enableHbiWorkspace
    allowPublicAccessWhenBehindVnet: false
  }
}


output amlid string = aml.id