param currentDate string = utcNow('yyyy-MM-dd')
param AzureMLName string
param DatabricksName string
param StorageAccountName string
param DatabricksManagedRGName string = concat(subscription().id,'/resourceGroups/',DatabricksName,'-rg-', uniqueString(resourceGroup().id))
param enableHbiWorkspace bool = false
param akvName string
param ainame string


var tagValues = {
  CreatedBy: 'MG'
  deploymentDate: currentDate
  project: 'Project-Name'
  business_unit: 'anumer-or-name'
  environment: 'nprod'
}

module sta 'Modules/storageAccount.bicep' = {
  name: 'sta'
  params: {
    tagValues: tagValues
    StorageAccountName: StorageAccountName

  }
}

module dbr 'Modules/Databricks.bicep' = {
  name: 'dbr'
  params: {
    tagValues: tagValues
    DatabricksName:DatabricksName
    DatabricksManagedRGName:DatabricksManagedRGName

  }
}



module appInsights 'Modules/ai-web.bicep' = {
  name: 'deploy-appinsights-web'
  scope: resourceGroup()
  params: {
    tagValues: tagValues
    ainame: ainame
  }
}


module akv 'Modules/akv.bicep' = {
  name: 'akv'
  params: {
    tagValues: tagValues
    akvName: akvName
  }
}


module acr 'Modules/acr.bicep' = {
  name: 'deploy-acr'
  scope: resourceGroup()
  params: {
    name: 'acr${uniqueString(resourceGroup().id)}'
    tagValues: tagValues
  }
}


module aml 'Modules/AzureML.bicep' = {
  name: 'aml'
  params: {
    tagValues: tagValues
    AzureMLName: AzureMLName
    enableHbiWorkspace: enableHbiWorkspace
    keyVaultID: akv.outputs.akvid
    storageAccountID: sta.outputs.staid
    applicationInsightsID: appInsights.outputs.aiId
    containerRegistryID: acr.outputs.acrId

  
  }
}
