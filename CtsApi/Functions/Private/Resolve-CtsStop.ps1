<#
.SYNOPSIS
Resolves stop/line/destination filters into an array of CTS stops
#>
function Resolve-CtsStop {
  [OutputType([Stop])]
  [CmdletBinding()]
  param(
    [String[]]$Stop = (''),
    [String[]]$Line = (''),
    [String[]]$Destination = (''),
    [Switch]$Force,
    [Switch]$NoCacheFile
  )
  process {
    Get-CtsStopData -Force:$Force -NoCacheFile:$NoCacheFile | Where-Object {
      foreach ($StopName in $Stop) {
        if ($_.StopName -like "*$StopName*") {
          return $true
        }
      }
      return $false
    } | ForEach-Object {
      # Filter lines and destinations
      $_.Lines = $_.Lines | Where-Object {
        foreach ($LineName in $Line) {
          if ($_.LineRef -clike "*$LineName*") {
            return $true
          }
        }
      } | Where-Object {
        foreach ($DestName in $Destination) {
          if ($_.Destinations.DestinationName -like "*$DestName*") {
            return $true
          }
        }
        return $false
      }
      
      if ($_.Lines.Count -gt 0) {
        return [Stop]$_
      }
    }
  }
}
