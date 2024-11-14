param addressPrefixes array
param location string
param name string
param snet1 string
param snet2 string
param snet1prefix string
param snet2prefix string
param snet1delegation string
param snet2delegation string
param bastionsubnetprefix string
param nsgname string
param tags object


module virtualNetwork 'br/public:avm/res/network/virtual-network:0.4.0' = {
  name: 'virtualNetworkDeployment'
  params: {
    // Required parameters
    addressPrefixes: addressPrefixes
    name: name
    // Non-required parameters
    location: location
    subnets: [
      {
        name: snet1
        addressPrefix: snet1prefix
        networkSecurityGroupResourceId: networkSecurityGroup.outputs.resourceId
         delegation: snet1delegation
          
      }
      {
        name: snet2
        addressPrefix: snet2prefix
        delegation: snet2delegation
      }
      {
        name: 'AzureBastionSubnet'
        addressPrefix: bastionsubnetprefix
        
      }
    ]
    tags: tags
  }
}


module networkSecurityGroup 'br/public:avm/res/network/network-security-group:0.5.0' = {
  name: 'networkSecurityGroupDeployment'
  params: {
    // Required parameters
    name: nsgname 
    // Non-required parameters
    location: location
    securityRules: [
      {
        name: 'AllowDnsInbound'
        properties: {
          access: 'Allow'
          destinationAddressPrefix: '*'
          destinationPortRanges: [
            '53'
          ]
          direction: 'Inbound'
          priority: 150
          protocol: 'Udp'
          sourceAddressPrefix: '*'
          sourcePortRange: '*'
        }
      }
      {
        name: 'AllowDnsOutbound'
        properties: {
          access: 'Allow'
          destinationAddressPrefix: '*'
          destinationPortRanges: [
            '53'
          ]
          direction: 'Outbound'
          priority: 150
          protocol: 'Udp'
          sourceAddressPrefix: '*'
          sourcePortRange: '*'
        }
      }
    ]
    tags: tags
  }
}
