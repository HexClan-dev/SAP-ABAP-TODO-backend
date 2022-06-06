@AbapCatalog.sqlViewName: 'ZITODO'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'TODO Basic CDS View'
@OData.publish: true
define view Z_I_TODO as select from ztodo {
    key id as Id,
    title as Title,
    description as Description,
    endtime as EndTime,
//    enddate as EndDate,
    status as Status
}
