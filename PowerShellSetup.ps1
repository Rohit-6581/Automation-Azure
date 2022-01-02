$PSVersionTable.PSVersion
Get-ExecutionPolicy
Set-ExecutionPolicy Unrestricted
#Install-Module -Name Az -Force -AllowClobber
Install-Module -Name Az -Scope CurrentUser -Repository PSGallery -Force
Import-Module Az
(Get-Module).Name
Connect-AzAccount
(Get-AzContext).Name

Connect-AzAccount -Tenant 'XXX' -SubscriptionId 'YYYY'



Disconnect-AzAccount