<#
.SYNOPSIS
Retrieves the raw CTS stop points and cache it locally
#>
function Get-CtsStopData {
  [OutputType([CtsAnnotatedStopPointStructure])]
  [CmdletBinding()]
  param(
    [Switch]$Force,
    [Switch]$NoCache
  )
  process {
    $StopPointsPath = [System.IO.Path]::GetTempPath() | Join-Path -ChildPath 'cts-stop-points.json'
    $StopPointsExpired = $true

    if (Test-Path -Path $StopPointsPath) {
      try {
        [CtsStopPointsDelivery]$StopPoints = Get-Content -Path $StopPointsPath -Raw | ConvertFrom-Json
        if (-not $Force) {
          $StopPointsExpired = [DateTime]$StopPoints.ResponseTimestamp -lt ([DateTime]::Now - $Script:StopCacheValidFor)
          if ($StopPointsExpired) {
            Write-Verbose -Message 'Cached stop data has expired'
          }
        }
      } catch {
        Write-Warning -Message "Error loading cached stops: $($_.Exception.Message)"
      }
    } else {
      Write-Verbose -Message 'Cached stop data is absent'
    }

    if ($StopPointsExpired) {
      try {
        $Response = Invoke-CtsApi -Path 'siri/2.0/stoppoints-discovery' -Query @{ IncludeLinesDestinations = $true }
        [CtsStopPointsDelivery]$StopPoints = $Response.StopPointsDelivery
      } catch {
        throw $_
      }
    } else {
      Write-Verbose -Message "Using cached stop data: $StopPointsPath"
    }

    if (-not $NoCache -and $StopPointsExpired) {
      $StopPoints | ConvertTo-Json -Depth 100 -Compress | Set-Content -Path $StopPointsPath -Force
      Write-Verbose -Message "Updated cached stop data: $StopPointsPath"
    }

    return $StopPoints.AnnotatedStopPointRef
  }
}
