param addressPrefixes array
param location string
param name string
param snet1 string
param snet2 string
param snet1prefix string
param snet2prefix string
param nsgname1 string
param nsgname2 string
param tags object
param natgwResourceId string


module virtualNetwork 'br/public:avm/res/network/virtual-network:0.4.0' = {
  name: '${uniqueString(deployment().name, location)}-vnet'
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
        natGatewayResourceId: natgwResourceId
      }
      {
        name: snet2
        addressPrefix: snet2prefix
        networkSecurityGroupResourceId: networkSecurityGroup2.outputs.resourceId
        natGatewayResourceId: natgwResourceId
      }
    ]
    tags: tags
  }
}

module networkSecurityGroup1 'br/public:avm/res/network/network-security-group:0.5.0' = {
  name: '${uniqueString(deployment().name, location)}-nsg'
  params: {
    // Required parameters
    name: nsgname1
    // Non-required parameters
    location: location
    
    tags: tags
  }
}

module networkSecurityGroup2 'br/public:avm/res/network/network-security-group:0.5.0' = {

  name: '${uniqueString(deployment().name, location)}-nsg2'
  params: {
    // Required parameters
    name: nsgname2
    // Non-required parameters
    location: location
    
    tags: tags
  }
}
