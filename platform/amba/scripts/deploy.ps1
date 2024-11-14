Connect-AzAccount -TenantId "6ca596a5-7058-4494-965c-b808e7ab8057"

Select-AzSubscription -Subscription "c20f6597-abec-4062-8957-c1be529df251"

$pseudoRootManagementGroup = "agri"

# ./amba/scripts/Start-AMBAOldArpCleanup.ps1 -pseudoRootManagementGroup $pseudoRootManagementGroup -WhatIf

#Modify the following variables to match your environment
$pseudoRootManagementGroup = "agri"
$identityManagementGroup = "agri-identity"
$managementManagementGroup = "agri-management"
$connectivityManagementGroup = "agri-connectivity"
$LZManagementGroup="agri-landing-zones"


#Run the following commands to initiate remediation
.\amba\scripts\Start-AMBARemediation.ps1 -managementGroupName $managementManagementGroup -policyName Alerting-Management
.\amba\scripts\Start-AMBARemediation.ps1 -managementGroupName $connectivityManagementGroup -policyName Alerting-Connectivity
.\amba\scripts\Start-AMBARemediation.ps1 -managementGroupName $identityManagementGroup -policyName Alerting-Identity
.\amba\scripts\Start-AMBARemediation.ps1 -managementGroupName $LZManagementGroup -policyName Alerting-LandingZone
.\amba\scripts\Start-AMBARemediation.ps1 -managementGroupName $pseudoRootManagementGroup -policyName Alerting-ServiceHealth
.\amba\scripts\Start-AMBARemediation.ps1 -managementGroupName $pseudoRootManagementGroup -policyName Notification-Assets
