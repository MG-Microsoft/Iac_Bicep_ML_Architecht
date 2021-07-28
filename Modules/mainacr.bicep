param tagValues object

module acrWithoutCMK 'acr.bicep' = {
  name: 'acrWithoutCMK'
  params: {
    name: 'acr${uniqueString(resourceGroup().id)}'
    tags: tagValues
  }
}


output acrId string = acrWithoutCMK.outputs.acrId
