#!/usr/bin/env pwsh

$plugin_path = (Get-Location).Path

Write-Output "## Wealth Management Schema Plugin Config Script ##"
Write-Output "$($plugin_path)"

$plugin = Get-Content -Raw -Path "$($plugin_path)/plugin.json" | ConvertFrom-Json

$schemas = Get-ChildItem "$($plugin_path)/config/schemas/*.json"

$data = Get-ChildItem "$($plugin_path)/data/*.json"

foreach ($schema in $schemas) {
    $schemaObject = Get-Content -Raw -Path "$($schema)" | ConvertFrom-Json -NoEnumerate -AsHashtable
    if ($null -ne $schemaObject) {
        $schemaJSON = ConvertTo-Json -depth 10 -Compress -InputObject $schemaObject
        $split_name = ($schema.BaseName).split("-",2)
        $priority = $split_name[0]
        $token = $split_name[1]

        & "/usr/local/fieldsets/bin/import-json.sh" -token "$($token)" -source 'wealth-management' -json "$($schemaJSON)" -type 'schema' -priority $($priority)
    }
}

foreach ($datapoint in $data) {
    $dataObject = Get-Content -Raw -Path "$($datapoint)" | ConvertFrom-Json -NoEnumerate -AsHashtable
    if ($null -ne $dataObject) {
        $dataJSON = ConvertTo-Json -depth 10 -Compress -InputObject $dataObject
        $split_name = ($datapoint.BaseName).split("-",2)
        $priority = $split_name[0]
        $token = $split_name[1]

        & "/usr/local/fieldsets/bin/import-json.sh" -token "$($token)" -source 'wealth-management' -json "$($dataJSON)" -type 'data' -priority $($priority)
    }
}

Exit
Exit-PSHostProcess