# 문제 채점 실행 (Windows PowerShell)
# 사용법: .\run.ps1 <문제 번호>      예) .\run.ps1 12
#         .\run.ps1 <문제 폴더 경로>  예) .\run.ps1 src/스택/문제0012_점진적과부하
param([Parameter(Mandatory = $true)][string]$Target)
$ErrorActionPreference = 'Stop'
Set-Location $PSScriptRoot
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

if ($Target -match '^\d+$') {
    $no  = '{0:D4}' -f [int]$Target
    $hit = Get-ChildItem -Path src -Directory | Get-ChildItem -Directory |
           Where-Object { $_.Name -like "문제${no}_*" } | Select-Object -First 1
    if (-not $hit) { Write-Host "❌ ${no}번 문제 폴더를 찾을 수 없습니다."; exit 1 }
    $rel = "$($hit.Parent.Name)/$($hit.Name)"
} else {
    $rel = ($Target -replace '\\', '/').TrimEnd('/') -replace '^(\./)?src/', ''
}
$pkg = $rel -replace '/', '.'

if (Test-Path out) { Remove-Item -Recurse -Force out }
New-Item -ItemType Directory -Path out | Out-Null

$sources = @('src/judge/Judge.java') + (Get-ChildItem "src/$rel" -Filter *.java | ForEach-Object { $_.FullName })
javac -encoding UTF-8 -d out @sources
if ($LASTEXITCODE -ne 0) { exit 1 }

Write-Host "▶ $rel`n"
java "-Dfile.encoding=UTF-8" "-Dstdout.encoding=UTF-8" -cp out "$pkg.SolutionTest"
