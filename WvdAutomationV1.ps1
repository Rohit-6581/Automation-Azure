#Main Script

$hostpoolsInSub = Get-AzWvdHostPool
$x = Get-AzTag  -ResourceId $hostpoolsInSub[1].Id
$tagloop = @()
$startTime = ""
$endTime = ""
$intendTime = 0
$intstartTime = 0
$tagloop= $x.Properties.TagsProperty
$startTime = $tagloop.Get_Item("StartTime")
$endTime = $tagloop.Get_Item("EndTime")

$startTime = $startTime.Replace(" ","")
$endTime = $endTime.Replace(" ","")

if($startTime.Contains("P")){
         $startTime = $startTime.Replace("PM","")
         $intstartTime = [int]$startTime
         $intstartTime = $intstartTime + 12
 }else{
    $startTime = $startTime.Replace("AM","")
    $intstartTime = [int]$startTime    
    }

if($endTime.Contains("P")){
        $endTime = $endTime.Replace("PM","")
        $intendTime = [int]$endTime
        $intendTime = $intendTime + 12

}else{
    $endTime = $endTime.Replace("AM","")
    $intendTime = [int]$endTime    
    }
    




$tDate =(Get-Date).ToUniversalTime()
$tz = [System.TimeZoneInfo]::FindSystemTimeZoneById("Eastern Standard Time")
$tCurrentTime = [System.TimeZoneInfo]::ConvertTimeFromUtc($tDate, $tz)

$IntcurrTime = [int]$tCurrentTime.Hour


#Stuff where my math comes in
$intstartTime
$intendTime


if($IntcurrTime -ge $intstartTime -and $IntcurrTime -le $intendTime){
    Write-Output("Change the VM state")
}

