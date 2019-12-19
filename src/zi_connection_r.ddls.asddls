@AbapCatalog.sqlViewName: 'ZICONNECT_R'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Read-Only E2E: Data Model Connection'

@UI.headerInfo.typeNamePlural: 'Connections'
@UI.headerInfo.typeName: 'Connection'
@Search.searchable: true 
define view ZI_CONNECTION_R
  as select from /dmo/connection as Connection
  association [1..*] to ZI_FLIGHT_R as _Flight on  $projection.AirlineID    = _Flight.AirlineID
                                               and $projection.ConnectionID = _Flight.ConnectionID
                                               
  association [1] to ZI_CARRIER as _Airline on $projection.AirlineID = _Airline.AirlineID                                             
{
      //Connection
      @UI.facet: [ {
             id: 'Connection',
             purpose:  #STANDARD,
             type:     #IDENTIFICATION_REFERENCE,
             label:    'Connection',
             position: 10 },
             {
             id: 'Flight',
             purpose:  #STANDARD,
             type:     #LINEITEM_REFERENCE,
             label:    'Flight',
             position: 20,
             targetElement: '_Flight'
             } ]

      @UI.lineItem: [ { position: 10, label: 'Airline'} ]
      @UI: { identification:[ { position: 10, label: 'Airline' } ]}
      @EndUserText.quickInfo: 'Airline that operates the flight'
      @ObjectModel.text.association: '_Airline'
      @Search.defaultSearchElement: true
      key Connection.carrier_id      as AirlineID,

      @UI.lineItem: [ { position: 20, label:'Connection Number' } ]
      @UI: { identification:[ { position: 20, label: 'Connection Number' } ] }
      key Connection.connection_id   as ConnectionID,


      @UI.lineItem: [ { position: 30, label: 'Departure Airport Code' } ]
      @UI: { identification:[ { position: 30, label: 'Departure Airport Code'} ] }
      @UI.selectionField: [ { position: 10 } ]
      @EndUserText.label: 'Departure Airport Code'
      @Consumption.valueHelpDefinition: [{ entity:{ name: 'ZI_AIRPORT' ,
                                                    element: 'AirportID'} }]
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.7                                                                                            
      Connection.airport_from_id as DepartureAirport,

      @UI.lineItem: [ { position: 40, label: 'Destination Airport Code' } ]
      @UI: { identification:[ { position: 40, label: 'Destination Airport Code'} ] }
      @UI.selectionField: [ { position: 20 } ]
      @EndUserText.label: 'Destination Airport Code'
      @Consumption.valueHelpDefinition: [{entity:{ name: 'ZI_AIRPORT',
                                                   element: 'AirportID' } }]
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.7                                               
      Connection.airport_to_id   as DestinationAirport,

      @UI.lineItem: [ { position: 50, label: 'Departure Time' } ]
      @UI: { identification:[ { position: 50, label: 'Departure Time' } ] }
      Connection.departure_time  as DepartureTime,

      @UI.lineItem: [ { position: 60 ,  label: 'Arrival Time' } ]
      @UI: { identification:[ { position: 60, label: 'Arrival Time'  } ] }
      Connection.arrival_time    as ArrivalTime,

      @Semantics.quantity.unitOfMeasure: 'DistanceUnit'
      @UI: { identification:[ { position: 70, label: 'Distance' } ] }
      Connection.distance        as Distance,

      @Semantics.unitOfMeasure: true
      Connection.distance_unit   as DistanceUnit,

      /*Associations*/
      _Airline,
      @Search.defaultSearchElement: true
      _Flight
}
