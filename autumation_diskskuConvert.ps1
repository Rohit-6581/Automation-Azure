
Set-AzContext -Subscription "" #Set Subcription to 

Connect-AzAccount -Tenant 'XX' -SubscriptionId 'YY'


$DiskArray = @('script_disk1_8a6fa37e403b4028982263521095eb26') #Concerned Disk Array

$disk = Get-AzDisk


#loop in through all the disk in subcription
$disk | ForEach-Object{
    
    #check the disk in of our concerned or not by checking it exist or not
    if($DiskArray -contains $_.Name ){
        
        $disktemp = $_
        #get VM name of the concerned disk
        $diskinVMs = $_.ManagedBy 
        $ownerstring = $diskinVMs.ToString()
        $VMname = $ownerstring.Substring($ownerstring.LastIndexOf("/")+1)
        $VMname

        #Get all the VM and its state from subcription
        $VMsinSUB = Get-AzVM -Status
        
        $VMsinSUB | ForEach-Object {
               
               #Is VMname matches with out disk VM and is the state is deallocated
               if($_.Name -eq $VMname -and $_.PowerState -eq "VM deallocated"){
                    #Update the disk to standard"
                    #$storageType = 'Standard_LRS' 
                    $disktemp.sku = [Microsoft.Azure.Management.Compute.Models.DiskSku]::new('Premium_LRS')
                    $disktemp | Update-AzDisk 
                 
               }
        }
    
    }
    
}

   
