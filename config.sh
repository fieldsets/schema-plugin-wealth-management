#!/usr/bin/env pwsh

$plugin_path = (Get-Location).Path
$home_path = [System.Environment]::GetEnvironmentVariable('HOME')

Write-Output "## CRM Schema Plugin Config Script ##"
Write-Output "$($plugin_path)"

$config = Get-Content -Raw -Path "$($plugin_path)/config.json" | ConvertFrom-Json

