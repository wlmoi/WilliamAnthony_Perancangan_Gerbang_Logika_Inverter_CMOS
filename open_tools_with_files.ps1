$ErrorActionPreference = "Stop"

$projectRoot = Split-Path -Parent $MyInvocation.MyCommand.Path
Set-Location $projectRoot

$ngspiceGui = Join-Path $projectRoot "tools\ngspice_bin\Spice64\bin\ngspice.exe"
$ngspiceDeck = "spice/inverter_cmos_sanity.spice"

$klayoutExe = "C:\Users\William Anthony\AppData\Roaming\KLayout\klayout_app.exe"
$klayoutFile = "layout/Inverter.mag"

$wslProjectPath = "/mnt/d/LinkedinProjects/WilliamAnthony_Perancangan_Gerbang_Logika_Inverter_CMOS"
$xschemFile = "$wslProjectPath/xschem/inverter.sch"
$xschemLog = "$wslProjectPath/xschem/xschem_open.log"

Write-Host "Opening Ngspice with file: $ngspiceDeck"
Start-Process $ngspiceGui -ArgumentList @("-i", "-a", $ngspiceDeck)

Write-Host "Opening KLayout with file: $klayoutFile"
Start-Process $klayoutExe -ArgumentList @($klayoutFile)

Write-Host "Opening Xschem with file: $xschemFile"
try {
	wsl -d Ubuntu -- bash -lc "pkill -f xschem || true" | Out-Null
	Start-Sleep -Seconds 1
} catch {
}
Start-Process wsl -ArgumentList @("-d", "Ubuntu", "--", "bash", "-lc", "export DISPLAY=:0; export WAYLAND_DISPLAY=wayland-0; xschem --log $xschemLog $xschemFile")

Write-Host "Done."
