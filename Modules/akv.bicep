param tagValues object
param akvName string

resource akv 'Microsoft.KeyVault/vaults@2021-04-01-preview' = {
  location: resourceGroup().location
  name: akvName 
  tags: tagValues
  properties: {
    sku: {
      family: 'A'
      name: 'standard'
    }
    tenantId: subscription().tenantId
    enableSoftDelete: true
    enablePurgeProtection: true
    softDeleteRetentionInDays: 90
    enabledForDeployment: false
    enabledForDiskEncryption: false
    enabledForTemplateDeployment: false
    enableRbacAuthorization: true
  }
}

output akvid string = akv.id