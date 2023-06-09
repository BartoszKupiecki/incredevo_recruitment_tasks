param parentName string
param keyVaultName string
param runtime string

resource parent 'Microsoft.Web/sites@2022-03-01' existing = {
  name: parentName
}

resource appServiceConfig 'Microsoft.Web/sites/config@2022-03-01' = {
  parent: parent
  name: 'appsettings'
  properties: {
    AzureWebJobsStorage: '@Microsoft.KeyVault(VaultName=${keyVaultName};SecretName=StorageAccount--ConnectionString)'
    WeatherDataStorage: '@Microsoft.KeyVault(VaultName=${keyVaultName};SecretName=StorageAccount--ConnectionString)'
    OpenWeatherApiKey: '@Microsoft.KeyVault(VaultName=${keyVaultName};SecretName=OpenWeather--ApiKey)'
    WEBSITE_CONTENTAZUREFILECONNECTIONSTRING: '@Microsoft.KeyVault(VaultName=${keyVaultName};SecretName=StorageAccount--ConnectionString)'
    FUNCTIONS_EXTENSION_VERSION: '~4'
    APPLICATIONINSIGHTS_CONNECTION_STRING: '@Microsoft.KeyVault(VaultName=${keyVaultName};SecretName=ApplicationInsights--ConnectionString)'
    FUNCTIONS_WORKER_RUNTIME: runtime
    WEBSITE_CONTENTSHARE: '${toLower(parentName)}${take(uniqueString(resourceGroup().id), 8)}'
  }
}
