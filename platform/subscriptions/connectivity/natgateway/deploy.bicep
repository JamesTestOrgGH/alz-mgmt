param location string
param name string
param tags object
param zone int
param zones array
param publicIPName string
param sKuTier string
param lock object


module natGateway 'br/public:avm/res/network/nat-gateway:1.2.0' = {
  name: '${uniqueString(deployment().name, location)}-natgw'
  params: {
    // Required parameters
    name: name
    zone: zone
    // Non-required parameters
    location: location
    lock: lock
    publicIPAddressObjects: [
      {
        name: publicIPName
        skuTier: sKuTier
        zones: zones
      }
    ]
    tags: tags
     
  }
}
