@AbapCatalog.sqlViewName: 'ZIAIRPORT_RE'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Information about the involved airports.'
define view ZI_AIRPORT as select from /dmo/airport as Airport
 {
    key Airport.airport_id as AirportID,
    
    Airport.name as Name,
    
    Airport.city as City,
    
    Airport.country as CountryCode
}
