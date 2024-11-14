param addressPrefixes array
param location string
param name string
param snet1 string
param snet1prefix string
param nsgname1 string
param tags object



targetScope = 'subscription'

resource resourcegroup 'Microsoft.Resources/resourceGroups@2024-03-01' = {
  name: 'rg-network-management-test-uksouth-01'
  location: 'uksouth'
}

module virtualNetwork 'br/public:avm/res/network/virtual-network:0.4.0' = {
  name: '${uniqueString(deployment().name, location)}-vnet'
  scope: resourcegroup
  params: {
    // Required parameters
    addressPrefixes:addressPrefixes
    
    name: name
    // Non-required parameters
    location: location
    subnets: [
      {
        name: snet1
        addressPrefix: snet1prefix
        networkSecurityGroupResourceId: networkSecurityGroup1.outputs.resourceId
      }
      
    ]
    tags: tags
  }
}

module networkSecurityGroup1 'br/public:avm/res/network/network-security-group:0.5.0' = {
  name: '${uniqueString(deployment().name, location)}-nsg'
  scope: resourcegroup
  params: {
    // Required parameters
    name: nsgname1
    // Non-required parameters
    location: location
    
    tags: tags
  }
}

