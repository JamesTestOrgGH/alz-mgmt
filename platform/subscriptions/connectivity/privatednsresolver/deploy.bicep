param name string
param virtualNetworkResourceId string
param inboundEndpointsname string
param inboundEndpointsSubnetResourceId string
param location string
param lock object
param outboundEndpointsname string
param outboundEndpointsSubnetResourceId string
param tags object


module dnsResolver 'br/public:avm/res/network/dns-resolver:0.5.0' = {
  name: 'dnsResolverDeployment'
  params: {
    // Required parameters
    name: name

    virtualNetworkResourceId: virtualNetworkResourceId
    // Non-required parameters
    inboundEndpoints: [
      {
        name: inboundEndpointsname
        subnetResourceId: inboundEndpointsSubnetResourceId
      }
    ]
    location: location
    lock: lock
    outboundEndpoints: [
      {
        name: outboundEndpointsname
        subnetResourceId: outboundEndpointsSubnetResourceId
      }
    ]
    
    tags: tags
  }
}




