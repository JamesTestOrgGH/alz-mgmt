
param name string
param location string
param frontendIPConfigurationname string
param subnetId string
param disableOutboundSnat bool
param enableFloatingIP bool
param enableTcpReset bool
param lbrprotocol string
param frontendPort int
param backendPort int
param idleTimeoutInMinutes int
param loadDistribution string
param protocol string
param intervalInSeconds int
param numberOfProbes int
param port int
param requestPath string
param skuName string
param tags object


module loadBalancer 'br/public:avm/res/network/load-balancer:0.4.0' = {
  name: '${uniqueString(deployment().name, location)}-lb'
  
  params: {
  
   frontendIPConfigurations: [
      {
        name: frontendIPConfigurationname
        subnetId: subnetId
        zones: [
          1
          2
          3
        ]
      }
    ]
    name: 'lb-${name}'
    // Non-required parameters
    backendAddressPools: [
      {
        name: 'bp-${name}'
      }
    ]
    
    loadBalancingRules: [
      {
        backendAddressPoolName: 'bp-${name}'
        backendPort: backendPort
        disableOutboundSnat: disableOutboundSnat
        enableFloatingIP: enableFloatingIP
        enableTcpReset: enableTcpReset
        frontendIPConfigurationName: frontendIPConfigurationname
        frontendPort: frontendPort
        idleTimeoutInMinutes: idleTimeoutInMinutes
        loadDistribution: loadDistribution
        name: 'lbr-${name}'
        probeName: 'prb-${name}'
        protocol: lbrprotocol
      }
    ]
    probes: [
      {
        intervalInSeconds: intervalInSeconds
        name: 'prb-${name}'
        numberOfProbes: numberOfProbes
        port: port
        protocol: protocol
        requestPath: requestPath
      }
    ]
    skuName: skuName
    tags: tags
    location: location
  }
}
