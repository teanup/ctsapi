function Get-CtsDeparture {
  <#
  .SYNOPSIS
  Retrieves the next departures at the specified CTS stops
  .DESCRIPTION
  TODO
  .EXAMPLE
  Get-CtsDeparture TODO
  .EXAMPLE
  Get-CtsDeparture TODO
  .OUTPUTS
  CTS departures for the relevant stops, destinations and departures
  #>
  [CmdletBinding(DefaultParameterSetName = 'Filters')]
  [OutputType([Departure])]
  param(
    # CTS line names to look up
    [Parameter(ParameterSetName = 'Filters')]
    [ArgumentCompleter([LineCompleter])]
    [AllowEmptyCollection()]
    [String[]]$Line,

    # CTS stop names to look up
    [Parameter(Position = 0, ParameterSetName = 'Filters')]
    [ArgumentCompleter([StopCompleter])]
    [AllowEmptyCollection()]
    [Alias('From')]
    [String[]]$Stop,

    # CTS destination names to look up
    [Parameter(Position = 1, ParameterSetName = 'Filters')]
    [ArgumentCompleter([DestinationCompleter])]
    [AllowEmptyCollection()]
    [Alias('To')]
    [String[]]$Destination,

    # CTS stop objects to use
    [Parameter(Mandatory, ValueFromPipeline, ParameterSetName = 'Object')]
    [AllowEmptyCollection()]
    [Stop[]]$StopObject,

    # Maximum number of departures per line, stop and destination
    [Parameter()]
    [ValidateRange(1, 8)]
    [Int]$MaxDepartures = 3,

    # Whether to bypass the CTS stop and departure caches
    [Parameter(DontShow)]
    [Switch]$Force,

    # Whether to avoid updating the CTS stop cache
    [Parameter(ParameterSetName = 'Filters', DontShow)]
    [Switch]$NoCacheFile
  )
  process {
    if ($PSCmdlet.ParameterSetName -eq 'Filters') {
      $FindParam = @{
        Line        = $Line
        Stop        = $Stop
        Destination = $Destination
        Force       = $Force
        NoCacheFile = $NoCacheFile
      }
      $StopObject = Find-CtsStop @FindParam
    }

    $NotBefore = [DateTime]::Now.AddSeconds(-10)
    $StopObject | ForEach-Object {
      $StopName = $_.Name
      $CtsDepartures = Get-CtsDepartureData -StopId $_.Id -MinDepartures ($MaxDepartures + 1) -Force:$Force

      $_.Lines | ForEach-Object {
        $StopLine = $_

        # Include all destinations for given line to support CTS network changes
        $CtsDepartures.MonitoredVehicleJourney | Where-Object {
          $_.LineRef -eq $StopLine.Name
        } | Group-Object -Property DestinationName | ForEach-Object {
          # Split departures per destination
          $Departure = [Departure]::new($StopName, [Line]::new($StopLine, @($_.Name)), $_.Group)
          $Departure.FilterTimes($NotBefore, $MaxDepartures)
          $Departure
        }
      }
    }
  }
}
