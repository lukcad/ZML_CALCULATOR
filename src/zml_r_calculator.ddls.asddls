@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: '##GENERATED ZMLCALCULATOR'
define root view entity ZML_R_CALCULATOR
  as select from zmlcalculator as Calculator
{
  key calc_uuid as CalcUUID,
  operand_a as OperandA,
  operand_b as OperandB,
  operator as Operator,
  calc_result as CalcResult,
  @Semantics.systemDateTime.createdAt: true
  created_at as CreatedAt,
  @Semantics.user.createdBy: true
  created_by as CreatedBy,
  @Semantics.user.lastChangedBy: true
  last_changed_by as LastChangedBy,
  @Semantics.systemDateTime.lastChangedAt: true
  last_changed_at as LastChangedAt,
  @Semantics.systemDateTime.localInstanceLastChangedAt: true
  local_last_changed_at as LocalLastChangedAt
  
}
