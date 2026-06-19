<#
.SYNOPSIS
Classes describing types returned by the CTS API

.LINK
https://api.cts-strasbourg.eu/v1/swagger.json
#>

class CtsAnnotatedDestinationStructure {
  [String[]]$DestinationName
  [Int]$DirectionRef
}

class CtsAnnotatedLineStructure {
  [CtsAnnotatedDestinationStructure[]]$Destinations
  [CtsExtensionAnnotatedLineStructure]$Extension
  [String]$LineName
  [String]$LineRef
}

class CtsAnnotatedStopPointStructure {
  [CtsExtensionAnnotatedStopPointStructure]$Extension
  [CtsAnnotatedLineStructure[]]$Lines
  [CtsLocation]$Location
  [String]$StopName
  [String]$StopPointRef
}

class CtsCTSGeneralMessage {
  [String]$ImpactedGroupOfLinesRef
  [String[]]$ImpactedLineRef
  [String]$ImpactEndDateTime
  [String]$ImpactStartDateTime
  [CtsMessage[]]$Message
  [CtsPriority]$Priority
  [Bool]$SendUpdatedNotificationsToCustomers
  [String]$TypeOfPassengerEquipmentRef
}

class CtsError {
  [String]$error
}

class CtsEstimatedCalls {
  [String]$DestinationName
  [String]$DestinationShortName
  [String]$ExpectedArrivalTime
  [String]$ExpectedDepartureTime
  [CtsExtensionEstimatedCalls]$Extension
  [String]$StopPointName
  [String]$StopPointRef
  [String]$Via
}

class CtsEstimatedTimetableDelivery {
  [CtsEstimatedTimetableVersionFrame[]]$EstimatedJourneyVersionFrame
  [String]$ResponseTimestamp
  [String]$ShortestPossibleCycle
  [String]$ValidUntil
  [String]$version
}

class CtsEstimatedTimetableVersionFrame {
  [CtsEstimatedVehicleJourney[]]$EstimatedVehicleJourney
  [String]$RecordedAtTime
}

class CtsEstimatedVehicleJourney {
  [Int]$DirectionRef
  [CtsEstimatedCalls[]]$EstimatedCalls
  [CtsExtensionEstimatedVehicleJourney]$Extension
  [CtsFramedVehicleJourneyRef]$FramedVehicleJourneyRef
  [Bool]$IsCompleteStopSequence
  [String]$LineRef
  [String]$PublishedLineName
}

class CtsExtensionAnnotatedLineStructure {
  [String]$RouteColor
  [String]$RouteTextColor
  [CtsRouteModeEnumeration]$RouteType
  # MISSING IN DOCUMENTATION
  [Bool]$LineHidden
  [String]$InformationPage
}

class CtsExtensionAnnotatedStopPointStructure {
  [Int]$distance
  [Bool]$IsFlexhopStop
  [String]$LogicalStopCode
  [String]$StopCode
}

class CtsExtensionEstimatedCalls {
  [String]$DataSource
  [Bool]$IsCheckOut
  [Bool]$IsRealTime
}

class CtsExtensionEstimatedVehicleJourney {
  [CtsVehicleModeEnumeration]$VehicleMode
}

class CtsExtensionMonitoredCall {
  [String]$DataSource
  [String]$Experimentation
  [Bool]$IsRealTime
}

class CtsFramedVehicleJourneyRef {
  [String]$DatedVehicleJourneySAERef
}

class CtsGeneralMessageDelivery {
  [CtsInfoMessage[]]$InfoMessage
  [String]$ResponseTimestamp
  [String]$ShortestPossibleCycle
  [String]$version
}

class CtsInfoMessage {
  [CtsCTSGeneralMessage]$Content
  [String]$formatRef
  [String]$InfoChannelRef
  [String]$InfoMessageIdentifier
  [String]$ItemIdentifier
  [String]$RecordedAtTime
  [String]$ValidUntilTime
}

enum CtsLang {
  FR
  EN
  DE
}

class CtsLinesDelivery {
  [CtsAnnotatedLineStructure[]]$AnnotatedLineRef
  [String]$RequestMessageRef
  [String]$ResponseTimestamp
  [String]$ShortestPossibleCycle
  [String]$ValidUntil
}

class CtsLineTimetableFile {
  [String]$EndValidity
  [String]$LineName
  [String]$LineRef
  [String]$StartValidity
  [String]$Url
}

class CtsLocation {
  [Int]$Latitude
  [Int]$Longitude
}

class CtsMessage {
  [CtsMessageText[]]$MessageText
  [String]$MessageZoneRef
}

class CtsMessageText {
  [CtsLang]$Lang
  [String]$Value
}

class CtsMonitoredCall {
  [String]$ExpectedArrivalTime
  [String]$ExpectedDepartureTime
  [CtsExtensionMonitoredCall]$Extension
  [Int]$Order
  [String]$StopCode
  [String]$StopPointName
}

class CtsMonitoredStopVisit {
  [CtsMonitoredVehicleJourney]$MonitoredVehicleJourney
  [String]$MonitoringRef
  [String]$RecordedAtTime
  [String]$StopCode
}

class CtsMonitoredVehicleJourney {
  [String]$DestinationName
  [String]$DestinationShortName
  [Int]$DirectionRef
  [CtsFramedVehicleJourneyRef]$FramedVehicleJourneyRef
  [String]$LineRef
  [CtsMonitoredCall]$MonitoredCall
  [CtsOnwardCall[]]$OnwardCall
  [CtsPreviousCall[]]$PreviousCall
  [String]$PublishedLineName
  [CtsVehicleModeEnumeration]$VehicleMode
  [String]$Via
}

class CtsOnwardCall {
  [String]$ExpectedArrivalTime
  [String]$ExpectedDepartureTime
  [Int]$Order
  [String]$StopCode
  [String]$StopPointName
}

class CtsParkAndRide {
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

class CtsPreviousCall {
  [Int]$Order
  [String]$StopCode
  [String]$StopPointName
}

enum CtsPriority {
  Normal
  Urgent
  Extrem
}

class CtsResponseEstimatedTimetableList {
  [CtsServiceDelivery]$ServiceDelivery
}

class CtsResponseGeneralMessageList {
  [CtsServiceDelivery]$ServiceDelivery
}

class CtsResponseLinesDiscoveryList {
  [CtsLinesDelivery]$LinesDelivery
}

class CtsResponseLineTimetablesFilesList {
  [CtsLineTimetableFile[]]$LineTimetablesFiles
}

class CtsResponseParkAndRideList {
  [CtsParkAndRide[]]$ParkAndRide
}

class CtsResponseRetailOutletList {
  [CtsRetailOutlet[]]$RetailOutlet
}

class CtsResponseRetailOutletType {
  [CtsRetailOutletType[]]$RetailOutletType
}

class CtsResponseStopMonitoringList {
  [CtsServiceDelivery]$ServiceDelivery
}

class CtsResponseStopPointsDiscoveryList {
  [CtsStopPointsDelivery]$StopPointsDelivery
}

class CtsResponseStopTimetablesFilesList {
  [CtsStopTimetableFile[]]$TimetablesFiles
}

class CtsResponseVelhopList {
  [CtsVelhop[]]$Velhop
}

class CtsResponseVeloparcList {
  [CtsVeloparc[]]$Veloparc
}

class CtsRetailOutlet {
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

class CtsRetailOutletType {
  [Int]$id
  [String]$type
}

enum CtsRouteModeEnumeration {
  bus
  tram
  undefined
}

class CtsServiceDelivery {
  [CtsEstimatedTimetableDelivery[]]$EstimatedTimetableDelivery
  [CtsGeneralMessageDelivery[]]$GeneralMessageDelivery
  [String]$RequestMessageRef
  [String]$ResponseTimestamp
  [CtsStopMonitoringDelivery[]]$StopMonitoringDelivery
  [CtsVehicleMonitoringDelivery[]]$VehicleMonitoringDelivery
}

enum CtsServiceType {
  store
  automaticStation
  storeAndAutomaticStation
}

class CtsStopMonitoringDelivery {
  [CtsMonitoredStopVisit[]]$MonitoredStopVisit
  [String[]]$MonitoringRef
  [String]$ResponseTimestamp
  [String]$ShortestPossibleCycle
  [String]$ValidUntil
  [String]$version
}

class CtsStopPointsDelivery {
  [CtsAnnotatedStopPointStructure[]]$AnnotatedStopPointRef
  [String]$RequestMessageRef
  [String]$ResponseTimestamp
}

class CtsStopTimetableFile {
  [String]$DestinationName
  [String]$EndValidity
  [String]$LineRef
  [String]$StartValidity
  [String]$StopCode
  [String]$Url
}

class CtsVehicleActivity {
  [CtsMonitoredVehicleJourney]$MonitoredVehicleJourney
  [String]$RecordedAtTime
}

enum CtsVehicleModeEnumeration {
  bus
  tram
  coach
  undefined
}

class CtsVehicleMonitoringDelivery {
  [String]$ResponseTimestamp
  [String]$ShortestPossibleCycle
  [String]$ValidUntil
  [CtsVehicleActivity[]]$VehicleActivity
}

class CtsVelhop {
  [String]$AccessInformation_DE
  [String]$AccessInformation_EN
  [String]$AccessInformation_FR
  [Int]$AvailableBikes
  [Int]$AvailableFreeBikeSpots
  [Bool]$BankCard
  [String]$Designation
  [Int]$Latitude
  [Int]$Longitude
  [CtsServiceType]$ServiceType
  [Int]$StationID
  [Int]$TotalBikeSpots
}

class CtsVeloparc {
  [String]$AccessInformation_DE
  [String]$AccessInformation_EN
  [String]$AccessInformation_FR
  [String]$Designation
  [Int]$Latitude
  [Int]$Longitude
}

$Script:ExportTypes += (
  'CtsAnnotatedDestinationStructure',
  'CtsAnnotatedLineStructure',
  'CtsAnnotatedStopPointStructure',
  'CtsCTSGeneralMessage',
  'CtsError',
  'CtsEstimatedCalls',
  'CtsEstimatedTimetableDelivery',
  'CtsEstimatedTimetableVersionFrame',
  'CtsEstimatedVehicleJourney',
  'CtsExtensionAnnotatedLineStructure',
  'CtsExtensionAnnotatedStopPointStructure',
  'CtsExtensionEstimatedCalls',
  'CtsExtensionEstimatedVehicleJourney',
  'CtsExtensionMonitoredCall',
  'CtsFramedVehicleJourneyRef',
  'CtsGeneralMessageDelivery',
  'CtsInfoMessage',
  'CtsLang',
  'CtsLinesDelivery',
  'CtsLineTimetableFile',
  'CtsLocation',
  'CtsMessage',
  'CtsMessageText',
  'CtsMonitoredCall',
  'CtsMonitoredStopVisit',
  'CtsMonitoredVehicleJourney',
  'CtsOnwardCall',
  'CtsParkAndRide',
  'CtsPreviousCall',
  'CtsPriority',
  'CtsResponseEstimatedTimetableList',
  'CtsResponseGeneralMessageList',
  'CtsResponseLinesDiscoveryList',
  'CtsResponseLineTimetablesFilesList',
  'CtsResponseParkAndRideList',
  'CtsResponseRetailOutletList',
  'CtsResponseRetailOutletType',
  'CtsResponseStopMonitoringList',
  'CtsResponseStopPointsDiscoveryList',
  'CtsResponseStopTimetablesFilesList',
  'CtsResponseVelhopList',
  'CtsResponseVeloparcList',
  'CtsRetailOutlet',
  'CtsRetailOutletType',
  'CtsRouteModeEnumeration',
  'CtsServiceDelivery',
  'CtsServiceType',
  'CtsStopMonitoringDelivery',
  'CtsStopPointsDelivery',
  'CtsStopTimetableFile',
  'CtsVehicleActivity',
  'CtsVehicleModeEnumeration',
  'CtsVehicleMonitoringDelivery',
  'CtsVelhop',
  'CtsVeloparc'
)
