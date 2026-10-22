# 새 문제 폴더 만들기 (Windows PowerShell)
# 사용법: .\new.ps1 <분류> <문제 제목>
# 예시  : .\new.ps1 스택 점진적과부하
param(
    [Parameter(Mandatory = $true)][string]$Category,
    [Parameter(Mandatory = $true, ValueFromRemainingArguments = $true)][string[]]$TitleParts
)
$ErrorActionPreference = 'Stop'
Set-Location $PSScriptRoot
$utf8 = New-Object System.Text.UTF8Encoding $false   # BOM 없는 UTF-8 (javac 오류 방지)

$title = ($TitleParts -join ' ')
$safe  = ($title -replace '[^\p{L}\p{Nd}_]+', '_').Trim('_')

$last = Get-ChildItem -Path src -Directory -ErrorAction SilentlyContinue |
        Get-ChildItem -Directory |
        ForEach-Object { if ($_.Name -match '^문제(\d{4})_') { [int]$Matches[1] } } |
        Sort-Object | Select-Object -Last 1
if (-not $last) { $last = 0 }
$no = '{0:D4}' -f ($last + 1)

$dir   = "src/$Category/문제${no}_$safe"
$pkg   = "$Category.문제${no}_$safe"
$today = Get-Date -Format 'yyyy-MM-dd'

New-Item -ItemType Directory -Force -Path $dir | Out-Null
foreach ($f in 'Solution.java', 'SolutionTest.java', 'README.md') {
    $text = [System.IO.File]::ReadAllText((Join-Path $PSScriptRoot "templates/$f.tpl"), $utf8)
    $text = $text.Replace('{{PACKAGE}}', $pkg).Replace('{{TITLE}}', $title).Replace('{{NO}}', $no)
    $text = $text.Replace('{{CATEGORY}}', $Category).Replace('{{DATE}}', $today)
    [System.IO.File]::WriteAllText((Join-Path $PSScriptRoot "$dir/$f"), $text, $utf8)
}

$row = "| $no | [$title]($dir/README.md) | $Category | $today | ⬜ |`n"
[System.IO.File]::AppendAllText((Join-Path $PSScriptRoot '문제목록.md'), $row, $utf8)

Write-Host "✅ 생성 완료: $dir"
Write-Host "   1) README.md 에 문제 붙여넣기"
Write-Host "   2) Solution.java 풀기"
Write-Host "   3) SolutionTest.java 에 입출력 예 적기"
Write-Host "   4) .\run.ps1 $([int]$no) 로 채점"
