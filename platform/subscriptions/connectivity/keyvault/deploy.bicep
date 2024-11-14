param name string
param location string
param enablepurgeProtection bool
param enableSoftDelete bool
param tags object




targetScope = 'subscription'

resource resourcegroup 'Microsoft.Resources/resourceGroups@2024-03-01' = {
  name: 'rg-keyvault-zscaler-connectivity-test-uksouth-01'
  location: 'uksouth'
}


module vault 'br/public:avm/res/key-vault/vault:0.9.0' = {
  name: '${uniqueString(deployment().name, location)}-keyvault'
  scope: resourcegroup
  params: {
    // Required parameters
    name: name
    // Non-required parameters
    enablePurgeProtection: enablepurgeProtection
    enableSoftDelete: enableSoftDelete
    location: location
    tags: tags
  }
}
