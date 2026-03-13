# Jalankan dari root project:
# powershell -ExecutionPolicy Bypass -File submission/pack_submission.ps1

$ErrorActionPreference = "Stop"

$projectRoot = Resolve-Path "$PSScriptRoot\.."
$zipName = "Tugas4_WilliamAnthony_13223048.zip"
$zipPath = Join-Path $projectRoot $zipName

if (Test-Path $zipPath) {
    Remove-Item $zipPath -Force
}

$itemsToZip = @(
    "docs",
    "xschem",
    "spice",
    "layout",
    "lvs",
    "README.md"
)

$fullItems = $itemsToZip | ForEach-Object { Join-Path $projectRoot $_ }

Compress-Archive -Path $fullItems -DestinationPath $zipPath -Force
Write-Host "ZIP berhasil dibuat: $zipPath"
