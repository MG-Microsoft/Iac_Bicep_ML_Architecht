param ainame string 
param tagValues object

resource ai 'Microsoft.Insights/components@2020-02-02-preview' = {
  name: ainame
  tags: tagValues
  location: resourceGroup().location
  kind: 'web'
  properties: {
    Application_Type: 'web'
  }
}

output aiId string = ai.id
