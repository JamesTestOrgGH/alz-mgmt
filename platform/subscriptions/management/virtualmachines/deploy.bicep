targetScope = 'subscription'
param subscriptionId string
param kvResourceGroup string 
param keyvaultname string 
param location string
param name string
param resourceGroupName string
param adminusername string
param imageReference object
param subnetResourceId string
param osdisk object
param ostype string
param vmsize string
param zone int



// Reference the existing Key Vault
resource keyVault 'Microsoft.KeyVault/vaults@2023-07-01' existing = {
  name: keyvaultname
  scope: resourceGroup(subscriptionId,kvResourceGroup)
}

resource resourcegroup 'Microsoft.Resources/resourceGroups@2024-03-01' = {
  name: resourceGroupName
  location: location
}

module virtualMachine 'br/public:avm/res/compute/virtual-machine:0.8.0' = {
  name: '${uniqueString(deployment().name, location)}-keyvault'
  scope: resourcegroup
  params: {
    // Required parameters
    adminUsername: adminusername
    adminPassword: keyVault.getSecret('adminPassword')
    imageReference: imageReference
    name: name
    nicConfigurations: [
      {
        ipConfigurations: [
          {
            name: 'ipconfig01'
            subnetResourceId: subnetResourceId
          }
        ]
        nicSuffix: '-nic-01'
      }
    ]
    osDisk: osdisk
    extensionGuestConfigurationExtension: {
      enabled: true
    }
    osType: ostype
    vmSize: vmsize
    zone: zone
    location: location
  }
  dependsOn: [
    keyVault
  ]
}
