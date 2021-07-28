param location string = resourceGroup().location
param tagValues object
param StorageAccountName string


resource sta 'Microsoft.Storage/storageAccounts@2021-01-01' = {
  name: StorageAccountName
  location: location
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
  tags: tagValues
}

output staid string = sta.id
