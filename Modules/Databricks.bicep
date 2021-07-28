param location string = resourceGroup().location
param tagValues object
param DatabricksName string
param DatabricksManagedRGName string = concat(subscription().id,'/resourceGroups/',DatabricksName,'-rg-', uniqueString(resourceGroup().id))




resource dbr 'Microsoft.Databricks/workspaces@2018-04-01' = {
  name: DatabricksName
  tags: tagValues
  location: location
  properties: {
    managedResourceGroupId: DatabricksManagedRGName
  }
  sku: {
    name: 'standard'
  }
}

output dbrid string = dbr.id
