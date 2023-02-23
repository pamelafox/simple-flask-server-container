param name string
param location string = resourceGroup().location
param tags object = {}

param appServicePlanId string
param containerRegistryName string
param imageName string = ''
param keyVaultName string
param serviceName string = 'web'

module app 'core/host/appservice.bicep' = {
  name: '${serviceName}-appservice'
  params: {
    name: name
    location: location
    tags: union(tags, { 'azd-service-name': serviceName })
    appServicePlanId: appServicePlanId
    runtimeName: 'docker'
    runtimeVersion: imageName
    keyVaultName: keyVault.name
    targetPort: 5000
  }
}

resource keyVault 'Microsoft.KeyVault/vaults@2022-07-01' existing = {
  name: keyVaultName
}

output SERVICE_WEB_IDENTITY_PRINCIPAL_ID string = app.outputs.identityPrincipalId
output SERVICE_WEB_NAME string = app.outputs.name
output SERVICE_WEB_URI string = app.outputs.uri
output SERVICE_WEB_IMAGE_NAME string = app.outputs.imageName
