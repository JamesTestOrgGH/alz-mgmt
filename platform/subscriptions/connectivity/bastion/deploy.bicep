
param name string
param location string
param lock object
param publicIPAddressversion string
param publicIPAllocationMethod string
param publicIPSku string
param publicIPSkuTier string
param tags object
param bastionsku string
param vNetId string
param bastionSubnetPublicIpResourceId string
param disableCopyPaste bool
param enableFileCopy bool
param enableIpConnect bool
param enableShareableLink bool
param scaleUnits int

targetScope = 'subscription'

resource resourceGroup 'Microsoft.Resources/resourceGroups@2024-03-01' = {
  name: 'rg-${name}'
  location: location
  tags: tags
  
}


module publicIpAddress 'br/public:avm/res/network/public-ip-address:0.6.0' = {
  name: '${uniqueString(deployment().name, location)}-publicIp'
  scope: resourceGroup
  params: {
    // Required parameters
    name: 'pip-${name}'
    // Non-required parameters
    location: location
    lock: lock
    publicIPAddressVersion: publicIPAddressversion
    publicIPAllocationMethod: publicIPAllocationMethod
    
    skuName: publicIPSku
    skuTier: publicIPSkuTier
    tags: tags
  }
}


module bastionHost 'br/public:avm/res/network/bastion-host:0.4.0' = {
  name: '${uniqueString(deployment().name, location)}-bastion'
  scope: resourceGroup
  params: {
    // Required parameters
    name: name
    virtualNetworkResourceId: vNetId
    // Non-required parameters
    bastionSubnetPublicIpResourceId: bastionSubnetPublicIpResourceId
    disableCopyPaste: disableCopyPaste
    enableFileCopy: enableFileCopy
    enableIpConnect: enableIpConnect
    enableShareableLink: enableShareableLink
    location: location
    scaleUnits: scaleUnits
    skuName: bastionsku
    tags: tags
  }
  dependsOn: [
    publicIpAddress
  ]
}



