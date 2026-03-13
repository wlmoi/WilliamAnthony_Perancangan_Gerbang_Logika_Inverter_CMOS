$ErrorActionPreference = "Stop"

$projectRoot = Split-Path -Parent $MyInvocation.MyCommand.Path
Set-Location $projectRoot

$wslProject = "/mnt/d/LinkedinProjects/WilliamAnthony_Perancangan_Gerbang_Logika_Inverter_CMOS"
$xschemSch = "$wslProject/xschem/inv_ngspice.sch"
$generatedNetlist = "$wslProject/xschem/inv_ngspice_generated.spice"

$ngspiceCon = Join-Path $projectRoot "tools\ngspice_bin\Spice64\bin\ngspice_con.exe"
$runnableSpice = Join-Path $projectRoot "spice\inv_ngspice_from_xschem_run.spice"
$logFile = Join-Path $projectRoot "spice\inv_ngspice_from_xschem.log"

Write-Host "[1/4] Generate netlist from Xschem schematic..."
$genCmd = "cd $wslProject; xschem -n -s -q -o $wslProject/xschem -N inv_ngspice_generated.spice $xschemSch"
wsl -d Ubuntu -- bash -lc $genCmd | Out-Null

$generatedPathWin = Join-Path $projectRoot "xschem\inv_ngspice_generated.spice"
if (!(Test-Path $generatedPathWin)) {
    throw "Netlist hasil generate tidak ditemukan: $generatedPathWin"
}

Write-Host "[2/4] Build runnable ngspice deck from generated netlist..."
$raw = Get-Content $generatedPathWin
$filtered = $raw | Where-Object { $_.Trim().ToLower() -ne ".end" }

$header = @(
"* Auto-generated runner from xschem/inv_ngspice.sch",
".param VCC=1.8",
".param ROUT=1k",
""
)

$footer = @(
"",
".tran 10p 30n",
".control",
"save all",
"run",
"meas tran VOUT_WHEN_IN_HIGH find v(Y) at=2n",
"meas tran VOUT_WHEN_IN_LOW  find v(Y) at=7n",
"wrdata spice/inv_ngspice_from_xschem.csv time v(A) v(Y)",
".endc",
".end"
)

$allLines = @()
$allLines += $header
$allLines += $filtered
$allLines += $footer
$allLines | Set-Content $runnableSpice

Write-Host "[3/4] Run ngspice using generated deck..."
& $ngspiceCon -b -o $logFile $runnableSpice

Write-Host "[4/4] Summary (proves source is inv_ngspice.sch):"
Select-String -Path $logFile -Pattern "Circuit:|VOUT_WHEN_IN_HIGH|VOUT_WHEN_IN_LOW|No. of Data Rows|Simulation executed" |
    ForEach-Object { $_.Line }

Write-Host "Done."
Write-Host "- Generated netlist: xschem/inv_ngspice_generated.spice"
Write-Host "- Runnable deck: spice/inv_ngspice_from_xschem_run.spice"
Write-Host "- Log: spice/inv_ngspice_from_xschem.log"
