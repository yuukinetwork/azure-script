Add-Type -AssemblyName System.Web.Extensions
$ScriptDir = Split-Path $MyInvocation.MyCommand.Path
$TargetFile = "test2.json"
$TargetFilePath = Join-Path $ScriptDir $TargetFile

if (Test-Path $TargetFilePath) {
    $JsonList = $(Get-Content $TargetFilePath)
}else {
    Write-Host "Cannot find the FlowLog File." -NoNewLine
    [Console]::ReadKey($true) > $null
    exit
}
$Serializer = New-Object System.Web.Script.Serialization.JavaScriptSerializer
$Hashtable = $Serializer.Deserialize($JsonList, [System.Collections.Hashtable])
# 
# Write-Output "State : Begin "
# $Hashtable.records.properties.flows.flows.flowTuples | Where-Object {$_ -like "*B*"}
# 
# Write-Output "`nState : Continue "
# $Hashtable.records.properties.flows.flows.flowTuples | Where-Object {$_ -like "*C*"}
# 
# Write-Output "`nState : End "
# $Hashtable.records.properties.flows.flows.flowTuples | Where-Object {$_ -like "*E*"}
$Data = @{}
$Data = ($Hashtable.records.properties.flows.flows.flowTuples).foreach{
    $s = $PSItem.Split(",")
    [pscustomobject]@{
        ID = -join $s[1..4]
        TS = $s[0];
        ETS = "";
        SIP = $s[1];
        DIP = $s[2];
        SPo = $s[3];
        DPo = $s[4];
        Pro = $s[5];
        TF = $s[6];
        TD = $s[7];
        FS = $s[8];
        PStD = $s[9];
        BStD = $s[10];
        PDtS = $s[11];
        BDtS = $s[12]
    }
}

#$idx = -1
#$counter = 0
# 
#while($TRUE){
#    $idx = [Array]::IndexOf($Data.ID, "10.5.16.413.67.143.11544931443", $idx + 1)
#    
#    if($idx -ne -1){
#        $counter ++
#        Write-Host ([string]$counter + "個目のインデックス→" + [string]$idx)
#    }else{
#        break
#    }
#}
#
#Write-Host ([string]$counter + '個存在します。') 

#{
#    if ( $Data.ID -contains (-join $s[1..4])) {
#        Write-Output "in"
#        $n = [Array]::IndexOf($Data.ID, -join $s[1..4]) 
#        switch ($s[8]) {
#            "C" {
#                $Data.PStD[$n] = [int]$Data.PStD[$n] + [int]$s[9]
#                $Data.BStD[$n] = [int]$Data.BStD[$n] + [int]$s[10]
#                $Data.PDtS[$n] = [int]$Data.PDtS[$n] + [int]$s[11]
#                $Data.BDtS[$n] = [int]$Data.BDtS[$n] + [int]$s[12]
#                if ($Data.FS[$n] -eq "E") {
#                    Write-Output "`nState End before State Continue.`n"
#                }  
#            }
#            Default {
#                [pscustomobject]@{
#                    ID = -join $s[1..4]
#                    TS = $s[0];
#                    ETS = "";
#                    SIP = $s[1];
#                    DIP = $s[2];
#                    SPo = $s[3];
#                    DPo = $s[4];
#                    Pro = $s[5];
#                    TF = $s[6];
#                    TD = $s[7];
#                    FS = $s[8];
#                    PStD = $s[9];
#                    BStD = $s[10];
#                    PDtS = $s[11];
#                    BDtS = $s[12]
#                }
#            }
#        } 
#    }else {
#        [pscustomobject]@{
#            ID = -join $s[1..4]
#            TS = $s[0];
#            ETS = "";
#            SIP = $s[1];
#            DIP = $s[2];
#            SPo = $s[3];
#            DPo = $s[4];
#            Pro = $s[5];
#            TF = $s[6];
#            TD = $s[7];
#            FS = $s[8];
#            PStD = $s[9];
#            BStD = $s[10];
#            PDtS = $s[11];
#            BDtS = $s[12]
#        }
#    }
#    
#}