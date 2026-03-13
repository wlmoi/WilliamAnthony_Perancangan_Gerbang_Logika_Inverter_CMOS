$ErrorActionPreference = "Stop"

$projectRoot = Split-Path -Parent $MyInvocation.MyCommand.Path
Set-Location $projectRoot

$ngspiceGui = Join-Path $projectRoot "tools\ngspice_bin\Spice64\bin\ngspice.exe"
$ngspiceCon = Join-Path $projectRoot "tools\ngspice_bin\Spice64\bin\ngspice_con.exe"
$klayoutExe = "C:\Users\William Anthony\AppData\Roaming\KLayout\klayout_app.exe"
$wslProjectPath = "/mnt/d/LinkedinProjects/WilliamAnthony_Perancangan_Gerbang_Logika_Inverter_CMOS"

$ngspiceDeck = "spice/inverter_cmos_sanity.spice"
$klayoutFile = "layout/Inverter.mag"
$xschemFile = "$wslProjectPath/xschem/inverter.sch"
$xschemLog = "$wslProjectPath/xschem/xschem_open.log"

Write-Host "[1/6] Open GUI tools: Ngspice, KLayout, Xschem"
if (Test-Path $ngspiceGui) {
    Start-Process $ngspiceGui -ArgumentList @("-i", "-a", $ngspiceDeck)
} else {
    Write-Warning "Ngspice GUI tidak ditemukan: $ngspiceGui"
}
if (Test-Path $klayoutExe) {
    Start-Process $klayoutExe -ArgumentList @($klayoutFile)
} else {
    Write-Warning "KLayout tidak ditemukan: $klayoutExe"
}
try {
    wsl -d Ubuntu -- bash -lc "pkill -f xschem || true" | Out-Null
    Start-Sleep -Seconds 1
} catch {
}
Start-Process wsl -ArgumentList @("-d", "Ubuntu", "--", "bash", "-lc", "export DISPLAY=:0; export WAYLAND_DISPLAY=wayland-0; xschem --log $xschemLog $xschemFile")

Write-Host "[2/6] Run Ngspice sanity (batch)"
Write-Host ("Run timestamp: {0}" -f (Get-Date -Format "yyyy-MM-dd HH:mm:ss"))
& $ngspiceCon -b -o "spice/ngspice_auto.log" "spice/inverter_cmos_sanity.spice"

Write-Host "[3/6] Show Ngspice summary"
Select-String -Path "spice/ngspice_auto.log" -Pattern "No. of Data Rows|vout_when_in_high|vout_when_in_low|tphl|tplh|Simulation executed" |
    ForEach-Object { $_.Line }

Write-Host "[4/6] Run DRC (Magic + GF180)"
$magicCmd = 'export PDK_ROOT=$HOME/.volare; cd /mnt/d/LinkedinProjects/WilliamAnthony_Perancangan_Gerbang_Logika_Inverter_CMOS; magic -dnull -noconsole -rcfile $PDK_ROOT/gf180mcuA/libs.tech/magic/gf180mcuA.magicrc layout/magic_drc_batch.tcl'
wsl -d Ubuntu -- bash -lc $magicCmd

Write-Host "[5/6] Run LVS (Netgen + GF180)"
$netgenCmd = 'export PDK_ROOT=$HOME/.volare; cd /mnt/d/LinkedinProjects/WilliamAnthony_Perancangan_Gerbang_Logika_Inverter_CMOS; netgen -batch source lvs/netgen_lvs_auto.tcl'
wsl -d Ubuntu -- bash -lc $netgenCmd

Write-Host "[6/6] Done. Key outputs:"
Write-Host "- spice/ngspice_auto.log"
Write-Host "- layout/drc_report.txt"
Write-Host "- lvs/lvs_report.log"
