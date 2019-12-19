@AbapCatalog.sqlViewName: 'ZICARRIER_RE'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Information about the airlines that operate the flights'

@Search.searchable: true
define view ZI_CARRIER as select from /dmo/carrier as Airline {
    key Airline.carrier_id as AirlineID,
    
    @Semantics.text: true
    @Search.defaultSearchElement: true
    @Search.fuzzinessThreshold: 0.7
    Airline.name as Name,
    
    @Semantics.currencyCode: true
    Airline.currency_code as CurrencyCode 
}
