<#
.SYNOPSIS
Classes describing simplified types for this module
#>

using namespace System.Management.Automation

class Formatted {
  [String] PadLeft([Int]$TotalWidth) {
    return $this.Pad($TotalWidth, $true, $false, $null)
  }

  [String] PadLeft([Int]$TotalWidth, [Object]$ToStringParam) {
    return $this.Pad($TotalWidth, $true, $true, $ToStringParam)
  }

  [String] PadRight([Int]$TotalWidth) {
    return $this.Pad($TotalWidth, $false, $false, $null)
  }

  [String] PadRight([Int]$TotalWidth, [Object]$ToStringParam) {
    return $this.Pad($TotalWidth, $false, $true, $ToStringParam)
  }

  hidden [String] Pad([Int]$TotalWidth, [Bool]$PadLeft, [Bool]$HasToStringParam, [Object]$ToStringParam) {
    $String = $this.ToString($HasToStringParam, $ToStringParam)
    $LenDiff = $TotalWidth - $this.VisibleLength($String)
    if ($LenDiff -le 0) {
      return $String
    } elseif ($PadLeft) {
      return (' ' * $LenDiff + $String)
    } else {
      return ($String + ' ' * $LenDiff)
    }
  }

  [Int] VisibleLength() {
    return $this.VisibleLength($false, $null)
  }

  [Int] VisibleLength([Object]$ToStringParam) {
    return $this.VisibleLength($true, $ToStringParam)
  }

  hidden [Int] VisibleLength([Bool]$HasToStringParam, [Object]$ToStringParam) {
    return $this.VisibleLength($this.ToString($HasToStringParam, $ToStringParam))
  }

  hidden [Int] VisibleLength([String]$String) {
    return ($String -replace '\e\[[\d;]+m').Length
  }

  hidden [String] ToString([Bool]$HasToStringParam, [Object]$ToStringParam) {
    if ($HasToStringParam) {
      return $this.ToString($ToStringParam)
    } else {
      return $this.ToString()
    }
  }
}

class Stop {
  [String]$Id
  [String]$Name
  [Line[]]$Lines

  Stop([CtsAnnotatedStopPointStructure]$CtsStop, [Line[]]$Lines) {
    $this.Id = $CtsStop.StopPointRef
    $this.Name = $CtsStop.StopName
    $this.Lines = $Lines
  }

  [String] ToString() {
    return "$($this.Name) ($($this.Lines.Name -join ','))"
  }
}

class Line : Formatted {
  [String]$Name
  [String]$DisplayName
  [String]$Description
  [String[]]$Destinations

  Line([CtsAnnotatedLineStructure]$CtsLine, [String[]]$Destinations) {
    $this.Name = $CtsLine.LineRef
    $this.Description = $CtsLine.LineName
    $this.Destinations = $Destinations

    $PSStyle = [PSStyle]::Instance
    $Text = ' ' + $this.Name + ' '
    $Background = $PSStyle.Background.FromRgb('0x' + $CtsLine.Extension.RouteColor)
    $Foreground = $PSStyle.Foreground.FromRgb('0x' + $CtsLine.Extension.RouteTextColor)
    $this.DisplayName = $PSStyle.Bold + $Background + $Foreground + $Text + $PSStyle.Reset
  }

  Line([Line]$Line, [String[]]$Destinations) {
    $this.Name = $Line.Name
    $this.DisplayName = $Line.DisplayName
    $this.Description = $Line.Description
    $this.Destinations = $Destinations
  }

  [String] ToString() {
    return $this.DisplayName + " `u{279C} " + ($this.Destinations -join ';')
  }
}

class Departure {
  [String]$StopName
  [Line]$Line
  [DepartureTime[]]$Times

  Departure([String]$StopName, [Line]$Line, [CtsMonitoredVehicleJourney[]]$CtsDepartures) {
    $this.StopName = $StopName
    $this.Line = $Line
    $this.Times = [DepartureTime[]]$CtsDepartures.MonitoredCall
  }

  FilterTimes([DateTime]$NotBefore, [Int]$MaxCount) {
    $this.Times = $this.Times | Where-Object {
      $_.Time -ge $NotBefore
    } | Select-Object -First $MaxCount
  }
}

class DepartureTime : Formatted {
  [DateTime]$Time
  [Bool]$Live

  DepartureTime([CtsMonitoredCall]$CtsDepartureTime) {
    $this.Time = $CtsDepartureTime.ExpectedDepartureTime
    $this.Live = $CtsDepartureTime.Extension.IsRealTime
  }

  [String] ToString() {
    return $this.ToString(0)
  }

  [String] ToString([DateTime]$ReferenceTime) {
    $PSStyle = [PSStyle]::Instance

    if ($ReferenceTime -eq 0) {
      $TimeText = $this.Time.ToString('HH:mm:ss')
    } else {
      $TimeSpan = $this.Time - $ReferenceTime
      if ($TimeSpan -le [TimeSpan]::FromSeconds(10)) {
        return $PSStyle.Bold + "`u{2B63}`u{2B63}" + $PSStyle.BoldOff
      }
      $TimeText = '{0}:{1:d2}' -f [Math]::Floor($TimeSpan.TotalMinutes), $TimeSpan.Seconds
    }

    if ($this.Live) {
      return $PSStyle.Bold + $TimeText + $PSStyle.BoldOff
    } else {
      return $PSStyle.Underline + $TimeText + $PSStyle.UnderlineOff
    }
  }
}
