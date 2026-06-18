<#
.SYNOPSIS
Classes describing types returned by the CTS API

.LINK
https://api.cts-strasbourg.eu/v1/swagger.json
#>

class AnnotatedDestinationStructure {
  [String[]]$DestinationName
  [Int]$DirectionRef
}

class AnnotatedLineStructure {
  [AnnotatedDestinationStructure[]]$Destinations
  [ExtensionAnnotatedLineStructure]$Extension
  [String]$LineName
  [String]$LineRef
}

class AnnotatedStopPointStructure {
  [ExtensionAnnotatedStopPointStructure]$Extension
  [AnnotatedLineStructure[]]$Lines
  [Location]$Location
  [String]$StopName
  [String]$StopPointRef
}

class CTSGeneralMessage {
  [String]$ImpactedGroupOfLinesRef
  [String[]]$ImpactedLineRef
  [String]$ImpactEndDateTime
  [String]$ImpactStartDateTime
  [Message[]]$Message
  [Priority]$Priority
  [Bool]$SendUpdatedNotificationsToCustomers
  [String]$TypeOfPassengerEquipmentRef
}

class Error {
  [String]$error
}

class EstimatedCalls {
  [String]$DestinationName
  [String]$DestinationShortName
  [String]$ExpectedArrivalTime
  [String]$ExpectedDepartureTime
  [ExtensionEstimatedCalls]$Extension
  [String]$StopPointName
  [String]$StopPointRef
  [String]$Via
}

class EstimatedTimetableDelivery {
  [EstimatedTimetableVersionFrame[]]$EstimatedJourneyVersionFrame
  [String]$ResponseTimestamp
  [String]$ShortestPossibleCycle
  [String]$ValidUntil
  [String]$version
}

class EstimatedTimetableVersionFrame {
  [EstimatedVehicleJourney[]]$EstimatedVehicleJourney
  [String]$RecordedAtTime
}

class EstimatedVehicleJourney {
  [Int]$DirectionRef
  [EstimatedCalls[]]$EstimatedCalls
  [ExtensionEstimatedVehicleJourney]$Extension
  [FramedVehicleJourneyRef]$FramedVehicleJourneyRef
  [Bool]$IsCompleteStopSequence
  [String]$LineRef
  [String]$PublishedLineName
}

class ExtensionAnnotatedLineStructure {
  [String]$RouteColor
  [String]$RouteTextColor
  [RouteModeEnumeration]$RouteType
  # MISSING IN DOCUMENTATION
  [Bool]$LineHidden
  [String]$InformationPage
}

class ExtensionAnnotatedStopPointStructure {
  [Int]$distance
  [Bool]$IsFlexhopStop
  [String]$LogicalStopCode
  [String]$StopCode
}

class ExtensionEstimatedCalls {
  [String]$DataSource
  [Bool]$IsCheckOut
  [Bool]$IsRealTime
}

class ExtensionEstimatedVehicleJourney {
  [VehicleModeEnumeration]$VehicleMode
}

class ExtensionMonitoredCall {
  [String]$DataSource
  [String]$Experimentation
  [Bool]$IsRealTime
}

class FramedVehicleJourneyRef {
  [String]$DatedVehicleJourneySAERef
}

class GeneralMessageDelivery {
  [InfoMessage[]]$InfoMessage
  [String]$ResponseTimestamp
  [String]$ShortestPossibleCycle
  [String]$version
}

class InfoMessage {
  [CTSGeneralMessage]$Content
  [String]$formatRef
  [String]$InfoChannelRef
  [String]$InfoMessageIdentifier
  [String]$ItemIdentifier
  [String]$RecordedAtTime
  [String]$ValidUntilTime
}

enum Lang {
  FR
  EN
  DE
}

class LinesDelivery {
  [AnnotatedLineStructure[]]$AnnotatedLineRef
  [String]$RequestMessageRef
  [String]$ResponseTimestamp
  [String]$ShortestPossibleCycle
  [String]$ValidUntil
}

class LineTimetableFile {
  [String]$EndValidity
  [String]$LineName
  [String]$LineRef
  [String]$StartValidity
  [String]$Url
}

class Location {
  [Int]$Latitude
  [Int]$Longitude
}

class Message {
  [MessageText[]]$MessageText
  [String]$MessageZoneRef
}

class MessageText {
  [Lang]$Lang
  [String]$Value
}

class MonitoredCall {
  [String]$ExpectedArrivalTime
  [String]$ExpectedDepartureTime
  [ExtensionMonitoredCall]$Extension
  [Int]$Order
  [String]$StopCode
  [String]$StopPointName
}

class MonitoredStopVisit {
  [MonitoredVehicleJourney]$MonitoredVehicleJourney
  [String]$MonitoringRef
  [String]$RecordedAtTime
  [String]$StopCode
}

class MonitoredVehicleJourney {
  [String]$DestinationName
  [String]$DestinationShortName
  [Int]$DirectionRef
  [FramedVehicleJourneyRef]$FramedVehicleJourneyRef
  [String]$LineRef
  [MonitoredCall]$MonitoredCall
  [OnwardCall[]]$OnwardCall
  [PreviousCall[]]$PreviousCall
  [String]$PublishedLineName
  [VehicleModeEnumeration]$VehicleMode
  [String]$Via
}

class OnwardCall {
  [String]$ExpectedArrivalTime
  [String]$ExpectedDepartureTime
  [Int]$Order
  [String]$StopCode
  [String]$StopPointName
}

class ParkAndRide {
  [String]$AccessInformation_DE
  [String]$AccessInformation_EN
  [String]$AccessInformation_FR
  [Int]$AvailableParkingSpots
  [String]$Designation
  [String]$LastUpdate
  [Int]$Latitude
  [Int]$Longitude
  [Bool]$Open
  [Int]$TotalParkingSpots
  [Int]$Variation
}

class PreviousCall {
  [Int]$Order
  [String]$StopCode
  [String]$StopPointName
}

enum Priority {
  Normal
  Urgent
  Extrem
}

class ResponseEstimatedTimetableList {
  [ServiceDelivery]$ServiceDelivery
}

class ResponseGeneralMessageList {
  [ServiceDelivery]$ServiceDelivery
}

class ResponseLinesDiscoveryList {
  [LinesDelivery]$LinesDelivery
}

class ResponseLineTimetablesFilesList {
  [LineTimetableFile[]]$LineTimetablesFiles
}

class ResponseParkAndRideList {
  [ParkAndRide[]]$ParkAndRide
}

class ResponseRetailOutletList {
  [RetailOutlet[]]$RetailOutlet
}

class ResponseRetailOutletType {
  [RetailOutletType[]]$RetailOutletType
}

class ResponseStopMonitoringList {
  [ServiceDelivery]$ServiceDelivery
}

class ResponseStopPointsDiscoveryList {
  [StopPointsDelivery]$StopPointsDelivery
}

class ResponseStopTimetablesFilesList {
  [StopTimetableFile[]]$TimetablesFiles
}

class ResponseVelhopList {
  [Velhop[]]$Velhop
}

class ResponseVeloparcList {
  [Veloparc[]]$Veloparc
}

class RetailOutlet {
  [String]$Address
  [Bool]$BadgeoTopUp
  [String]$Designation
  [Int]$Latitude
  [Int]$Longitude
  [String]$OpeningTimes
  [String]$RetailOutletType
  [Int]$RetailOutletTypeId
  [String[]]$Services
  [Bool]$TicketSales
}

class RetailOutletType {
  [Int]$id
  [String]$type
}

enum RouteModeEnumeration {
  bus
  tram
  undefined
}

class ServiceDelivery {
  [EstimatedTimetableDelivery[]]$EstimatedTimetableDelivery
  [GeneralMessageDelivery[]]$GeneralMessageDelivery
  [String]$RequestMessageRef
  [String]$ResponseTimestamp
  [StopMonitoringDelivery[]]$StopMonitoringDelivery
  [VehicleMonitoringDelivery[]]$VehicleMonitoringDelivery
}

enum ServiceType {
  store
  automaticStation
  storeAndAutomaticStation
}

class StopMonitoringDelivery {
  [MonitoredStopVisit[]]$MonitoredStopVisit
  [String[]]$MonitoringRef
  [String]$ResponseTimestamp
  [String]$ShortestPossibleCycle
  [String]$ValidUntil
  [String]$version
}

class StopPointsDelivery {
  [AnnotatedStopPointStructure[]]$AnnotatedStopPointRef
  [String]$RequestMessageRef
  [String]$ResponseTimestamp
}

class StopTimetableFile {
  [String]$DestinationName
  [String]$EndValidity
  [String]$LineRef
  [String]$StartValidity
  [String]$StopCode
  [String]$Url
}

class VehicleActivity {
  [MonitoredVehicleJourney]$MonitoredVehicleJourney
  [String]$RecordedAtTime
}

enum VehicleModeEnumeration {
  bus
  tram
  coach
  undefined
}

class VehicleMonitoringDelivery {
  [String]$ResponseTimestamp
  [String]$ShortestPossibleCycle
  [String]$ValidUntil
  [VehicleActivity[]]$VehicleActivity
}

class Velhop {
  [String]$AccessInformation_DE
  [String]$AccessInformation_EN
  [String]$AccessInformation_FR
  [Int]$AvailableBikes
  [Int]$AvailableFreeBikeSpots
  [Bool]$BankCard
  [String]$Designation
  [Int]$Latitude
  [Int]$Longitude
  [ServiceType]$ServiceType
  [Int]$StationID
  [Int]$TotalBikeSpots
}

class Veloparc {
  [String]$AccessInformation_DE
  [String]$AccessInformation_EN
  [String]$AccessInformation_FR
  [String]$Designation
  [Int]$Latitude
  [Int]$Longitude
}
