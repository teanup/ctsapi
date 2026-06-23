<#
.SYNOPSIS
Imports classes & functions and defines module-scope variables
#>

param(
  [String]$CtsApiKey
)

$Script:ExportTypes = [String[]]@()

# Dot-source PowerShell scripts
$Classes = Get-ChildItem -Path ($PSScriptRoot | Join-Path -ChildPath 'Classes') -Include '*.ps1' -Recurse
$Functions = Get-ChildItem -Path ($PSScriptRoot | Join-Path -ChildPath 'Functions') -Include '*.ps1' -Recurse
@($Classes) + @($Functions) | ForEach-Object { . $_.FullName }

# Export custom types
$TypeAccelerators = [PSCustomObject].Assembly.GetType('System.Management.Automation.TypeAccelerators')
foreach ($Type in $Script:ExportTypes) {
  if ($Type -as [System.Type]) {
    $null = $TypeAccelerators::Add($Type, $Type -as [System.Type])
  } else {
    Write-Warning -Message "Failed to export unknown type: $Type"
  }
}

# CTS API token
$CtsApiKeyPath = $PSScriptRoot | Join-Path -ChildPath 'cts-api.key'
if ($CtsApiKey) {
  Set-Content -Path $CtsApiKeyPath -Value $CtsApiKey -Force
} else {
  $CtsApiKey = Get-Content -Path $CtsApiKeyPath | Select-Object -First 1
}
if (-not $CtsApiKey) {
  Write-Warning -Message "Empty CTS API token. Set your token in '$CtsApiKeyPath' or import the module with: -ArgumentList <your-token>"
  $CtsApiKey = ''
}
Set-Variable -Name CtsApiToken -Value $CtsApiKey -Option Constant -Visibility Private -Scope Local

# Cache configuration
$Script:StopCacheValidFor = [TimeSpan]::FromDays(3)
$Script:DepartureCacheValidFor = [TimeSpan]::FromSeconds(30)
$Script:SafeRequestThreshold = 4
