Add-Type -AssemblyName System.Web.Extensions

$ScriptDir = Split-Path $MyInvocation.MyCommand.Path
Write-Output $ScriptDir

$TargetFile = "test2.json"
$TargetFilePath = Join-Path $ScriptDir $TargetFile

if(Test-Path $TargetFilePath){
    $JsonList = $(Get-Content $TargetFilePath)
}else{
    Write-Host "Cannot find the FlowLog File." -NoNewLine
    [Console]::ReadKey($true) > $null
    exit
}

$Serializer = New-Object System.Web.Script.Serialization.JavaScriptSerializer
$Hashtable = $Serializer.Deserialize($JsonList, [System.Collections.Hashtable])

Write-Output "State : Begin "
$Hashtable.records.properties.flows.flows.flowTuples | Where-Object {$_ -like "*B*"}

Write-Output "`nState : Continue "
$Hashtable.records.properties.flows.flows.flowTuples | Where-Object {$_ -like "*C*"}

Write-Output "`nState : End "
$Hashtable.records.properties.flows.flows.flowTuples | Where-Object {$_ -like "*E*"}
