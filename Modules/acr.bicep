param name string = 'acr${uniqueString(resourceGroup().id)}'
param tagValues object
param quarantinePolicy string = 'disabled'
param trustPolicyType string = 'Notary'
param trustPolicyStatus string = 'enabled'
param retentionPolicyDays int = 30
param retentionPolicyStatus string = 'enabled'


/* Configure ACR */
resource acr 'Microsoft.ContainerRegistry/registries@2020-11-01-preview' = {
  name: name
  tags: tagValues
  location: resourceGroup().location
  sku: {
    name: 'Premium'
  }
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    adminUserEnabled: true
    
    networkRuleSet: {
      defaultAction: 'Deny'
    }

    policies: {
      quarantinePolicy: {
        status: quarantinePolicy
      }
      trustPolicy: {
        type: trustPolicyType
        status: trustPolicyStatus
      }
      retentionPolicy: {
        days: retentionPolicyDays
        status: retentionPolicyStatus
      }
    }

    dataEndpointEnabled: false
    publicNetworkAccess: 'Disabled'
  }
}

output acrId string = acr.id
