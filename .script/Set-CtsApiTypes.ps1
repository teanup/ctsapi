<#
.SYNOPSIS
Parses the CTS API documentation to define compatible PowerShell types
#>
[CmdletBinding()]
param(
  [Parameter(Mandatory = $false)]
  [String]$Path,

  [Parameter(Mandatory = $false)]
  [String]$OpenApiUrl = 'https://api.cts-strasbourg.eu/v1/swagger.json'
)

$ErrorActionPreference = 'Stop'

function Get-CtsApiPropertyType {
  [OutputType([String])]
  param(
    [PSCustomObject]$InputObject
  )
  process {
    if ($InputObject.type) {
      switch ($InputObject.type) {
        'string' {
          return 'String'
        }
        'integer' {
          return 'Int'
        }
        'number' {
          return 'Int'
        }
        'boolean' {
          return 'Bool'
        }
        'array' {
          return "$(Get-CtsApiPropertyType -InputObject $InputObject.items)[]"
        }
        default {
          Write-Error -Message "Unknown property type: $_"
        }
      }
    } elseif ($InputObject.'$ref') {
      if ($InputObject.'$ref' -match '#/components/schemas/(?<type>\w+)') {
        return $Matches.type
      }
    } else {
      default {
        Write-Error -Message "Unknown property type: $($InputObject | ConvertTo-Json -Compress)"
      }
    }
  }
}

if ([String]::IsNullOrEmpty($Path)) {
  $Path = Split-Path -Path $PSScriptRoot -Parent | Join-Path -ChildPath 'CtsApi' -AdditionalChildPath 'Classes', 'CtsApi.ps1'
  Write-Verbose "Empty path for CTS API types, using default: $Path"
}

if (-not (Test-Path -Path $Path -PathType Leaf -IsValid)) {
  throw "Invalid path for CTS API types: $Path"
}

$OpenApi = Invoke-RestMethod -Uri $OpenApiUrl
$CtsTypes = $OpenApi.components.schemas
if ($null -eq $CtsTypes) {
  throw "Got invalid OpenAPI format from: $OpenApiUrl"
}

$null = New-Item -Path $Path -ItemType File -Force -Value @"
<#
.SYNOPSIS
Classes describing types returned by the CTS API

.LINK
$OpenApiUrl
#>

"@

($CtsTypes | Get-Member -View Extended).Name | ForEach-Object {
  $TypeName = $_
  $TypeObj = $CtsTypes.$TypeName
  switch ($TypeObj.type) {
    'object' {
      if ($TypeObj.properties) {
        $PropertyList = ($TypeObj.properties | Get-Member -View Extended).Name | ForEach-Object {
          $PropertyType = Get-CtsApiPropertyType -InputObject $TypeObj.properties.$_
          return "[$PropertyType]`$$_"
        }
        $PropertyText = $PropertyList -join "`n  "
        Add-Content -Path $Path -Value "`nclass $TypeName {`n  $PropertyText`n}"
      }
    }
    'string' {
      if ($TypeObj.enum) {
        $EnumValues = $TypeObj.enum -join "`n  "
        Add-Content -Path $Path -Value "`nenum $TypeName {`n  $EnumValues`n}"
      }
    }
    default {
      Write-Error -Message "Unknown API type: $TypeName"
    }
  }
}
