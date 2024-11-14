targetScope = 'subscription'
param subscriptionId string = 'b344188e-4e43-430c-bb68-e892be007536'
param kvResourceGroup string = 'rg-keyvault-zscaler-connectivity-test-uksouth-01'
param keyvaultname string = 'kv-con-test-uksouth-01'
param location string = 'uksouth'

// Reference the existing Key Vault
resource keyVault 'Microsoft.KeyVault/vaults@2023-07-01' existing = {
  name: keyvaultname
  scope: resourceGroup(subscriptionId,kvResourceGroup)
}


resource resourcegroup 'Microsoft.Resources/resourceGroups@2024-03-01' = {
  name: 'rg-vms-zscaler-connectivity-test-uksouth-01'
  location: location
}

module virtualMachineScaleSet 'br/public:avm/res/compute/virtual-machine-scale-set:0.4.0' = {
  name: 'virtualMachineScaleSetDeployment'
  scope: resourcegroup
  params: {
    // Required parameters
    adminUsername: 'localAdminUser'
    adminPassword: keyVault.getSecret('adminPassword')
    imageReference: {
      offer: 'zia_cloud_connector'
      publisher: 'zscaler1579058425289'
      sku: 'zs_ser_gen1_cc_01'
      version: 'latest'
    }
    name: 'vm-zscaler-cc-connectivity-test-uksouth-10'
    nicConfigurations: [
      {
        ipConfigurations: [
          {
            name: 'ipconfig1'
            properties: {
              subnet: {
                id: '/subscriptions/b344188e-4e43-430c-bb68-e892be007536/resourceGroups/rg-alz-connectivity/providers/Microsoft.Network/virtualNetworks/vnet-zscaler-connectivity-test-uksouth-01/subnets/snet-zscaler-cc-1'
              }
            }
          }
        ]
        nicSuffix: '-nic01'
      }
]
    osDisk: {
      createOption: 'fromImage'
      diskSizeGB: '128'
      managedDisk: {
        storageAccountType: 'Premium_LRS'
      }
    }
    osType: 'Linux'
    skuName: 'Standard_D2s_v3'
    availabilityZones: [
      1,2,3
    ]
    // Non-required parameters
    location: location
    bypassPlatformSafetyChecksOnUserSchedule: true
    patchMode: 'ImageDefault'
    plan: {
      name: 'zs_ser_gen1_cc_01'
      product: 'zia_cloud_connector'
      publisher: 'zscaler1579058425289'
    }
    orchestrationMode: 'Flexible'
    prioritizeUnhealthyInstances: false

    scaleSetFaultDomain: 1
    scaleInPolicy: {
      rules: [
        'Default'
      ]
  }
    extensionHealthConfig:{
      enabled: false
      
  }
    skuCapacity: 3
    tags: {
      Environment: 'Non-Prod'
      Role: 'DeploymentValidation'
    }
    vmNamePrefix: 'ss-'
  }
}
