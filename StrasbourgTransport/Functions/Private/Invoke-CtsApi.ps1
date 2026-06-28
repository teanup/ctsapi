<#
.SYNOPSIS
Performs a request to the CTS API
#>
function Invoke-CtsApi {
  [CmdletBinding()]
  [OutputType([PSCustomObject])]
  param(
    [Parameter(Mandatory = $true)]
    [ValidateNotNullOrEmpty()]
    [String]$Path,

    [Parameter(Mandatory = $false)]
    [AllowNull()]
    [Hashtable]$Query,

    [Parameter(Mandatory = $false)]
    [ValidateNotNull()]
    [String]$Token = $Script:CtsApiToken,

    [Parameter(Mandatory = $false)]
    [ValidateNotNullOrEmpty()]
    [String]$BaseUrl = 'https://api.cts-strasbourg.eu/v1/'
  )
  process {
    $RequestParam = @{
      Method         = 'Get'
      Uri            = $BaseUrl + $Path
      Body           = $Query
      Authentication = 'Basic'
      Credential     = [PSCredential]::new($Token, [SecureString]::new())
    }
    $Response = Invoke-RestMethod @RequestParam

    try {
      $CtsError = [CtsError]$Response
      return $CtsError.error
    } catch {
      return $Response
    }
  }
}
