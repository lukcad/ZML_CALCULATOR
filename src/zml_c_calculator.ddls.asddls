@AccessControl.authorizationCheck: #CHECK
@Metadata.allowExtensions: true
@EndUserText.label: 'Projection View for ZML_R_CALCULATOR'
define root view entity ZML_C_CALCULATOR
  provider contract transactional_query
  as projection on ZML_R_CALCULATOR
{
  key CalcUUID,
  OperandA,
  OperandB,
  Operator,
  CalcResult,
  LocalLastChangedAt
  
}
