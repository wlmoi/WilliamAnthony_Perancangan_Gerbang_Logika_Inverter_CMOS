$ErrorActionPreference = "Stop"

$projectRoot = Split-Path -Parent $MyInvocation.MyCommand.Path
Set-Location $projectRoot

$ngspiceGui = Join-Path $projectRoot "tools\ngspice_bin\Spice64\bin\ngspice.exe"
$ngspiceCon = Join-Path $projectRoot "tools\ngspice_bin\Spice64\bin\ngspice_con.exe"
$netlist = "spice/inverter_cmos_sanity.spice"
$logFile = "spice/ngspice_auto.log"

if (!(Test-Path $ngspiceGui) -or !(Test-Path $ngspiceCon)) {
    throw "Binary ngspice tidak ditemukan."
}

if (!(Test-Path $netlist)) {
    throw "File netlist tidak ditemukan: $netlist"
}

Write-Host "[1/3] Running batch for guaranteed result..."
Write-Host ("Run timestamp: {0}" -f (Get-Date -Format "yyyy-MM-dd HH:mm:ss"))
& $ngspiceCon -b -o $logFile $netlist

Write-Host "[2/3] Summary result:"
Select-String -Path $logFile -Pattern "No. of Data Rows|vout_when_in_high|vout_when_in_low|tphl|tplh|Simulation executed" |
    ForEach-Object { $_.Line }

Write-Host "[3/3] Opening interactive ngspice GUI (autorun netlist)..."
Start-Process $ngspiceGui -ArgumentList @("-i", "-a", $netlist)

Write-Host "Done. Log: $logFile"
