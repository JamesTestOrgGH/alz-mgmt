targetScope = 'subscription'
param subscriptionId string = 'b344188e-4e43-430c-bb68-e892be007536'
param kvResourceGroup string = 'rg-keyvault-zscaler-connectivity-test-uksouth-01'
param keyvaultname string = 'kv-con-test-uksouth-01'

// Reference the existing Key Vault
resource keyVault 'Microsoft.KeyVault/vaults@2023-07-01' existing = {
  name: keyvaultname
  scope: resourceGroup(subscriptionId,kvResourceGroup)
}


resource resourcegroup 'Microsoft.Resources/resourceGroups@2024-03-01' = {
  name: 'rg-vms-zscaler-connectivity-test-uksouth-01'
  location: 'uksouth'
}


module virtualMachine 'br/public:avm/res/compute/virtual-machine:0.7.0' = {
  name: 'virtualMachineDeployment'
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
    name: 'vm-zscaler-cc-connectivity-test-uksouth-01'
    nicConfigurations: [
      {
        ipConfigurations: [
          {
            name: 'ipconfig01'
            subnetResourceId: '/subscriptions/b344188e-4e43-430c-bb68-e892be007536/resourceGroups/rg-alz-connectivity/providers/Microsoft.Network/virtualNetworks/vnet-zscaler-connectivity-test-uksouth-01/subnets/snet-zscaler-cc-1'
          }
        ]
        nicSuffix: '-nic-01'
      }
    ]
    osDisk: {
      caching: 'ReadWrite'
      diskSizeGB: 128
      managedDisk: {
        storageAccountType: 'Premium_LRS'
      }
    }
    osType: 'Linux'
    vmSize: 'Standard_D2s_v3'
    zone: 1
    // Non-required parameters
    disablePasswordAuthentication: false
    location: 'uksouth'
    plan: {
      name: 'zs_ser_gen1_cc_01'
      product: 'zia_cloud_connector'
      publisher: 'zscaler1579058425289'
    }
    
  }
}

module virtualMachine2 'br/public:avm/res/compute/virtual-machine:0.7.0' = {
  name: 'virtualMachineDeployment2'
  scope: resourcegroup
  params: {
    // Required parameters
    adminUsername: 'localAdminUser'
    adminPassword: 'DonkeyMachine1!'
    imageReference: {
      offer: 'zia_cloud_connector'
      publisher: 'zscaler1579058425289'
      sku: 'zs_ser_gen1_cc_01'
      version: 'latest'
    }
    name: 'vm-zscaler-cc-connectivity-test-uksouth-02'
    nicConfigurations: [
      {
        ipConfigurations: [
          {
            name: 'ipconfig01'
            subnetResourceId: '/subscriptions/b344188e-4e43-430c-bb68-e892be007536/resourceGroups/rg-alz-connectivity/providers/Microsoft.Network/virtualNetworks/vnet-zscaler-connectivity-test-uksouth-01/subnets/snet-zscaler-cc-1'
          }
        ]
        nicSuffix: '-nic-01'
      }
    ]
    osDisk: {
      caching: 'ReadWrite'
      diskSizeGB: 128
      managedDisk: {
        storageAccountType: 'Premium_LRS'
      }
    }
    osType: 'Linux'
    vmSize: 'Standard_D2s_v3'
    zone: 2
    // Non-required parameters
    disablePasswordAuthentication: false
    location: 'uksouth'
    plan: {
      name: 'zs_ser_gen1_cc_01'
      product: 'zia_cloud_connector'
      publisher: 'zscaler1579058425289'
    }
    
  }
}
