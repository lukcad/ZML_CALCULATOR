CLASS lhc_calculator DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.
    METHODS:
      get_global_authorizations FOR GLOBAL AUTHORIZATION
        IMPORTING
        REQUEST requested_authorizations FOR Calculator
        RESULT result,
      CalculateCalcResult FOR DETERMINE ON MODIFY
        IMPORTING keys FOR Calculator~CalculateCalcResult.
ENDCLASS.

CLASS lhc_calculator IMPLEMENTATION.
  METHOD get_global_authorizations.
  ENDMETHOD.
  METHOD CalculateCalcResult.

    READ ENTITIES OF zml_r_calculator IN LOCAL MODE
    ENTITY Calculator
    FIELDS ( OperandA OperandB Operator CalcResult )
    WITH CORRESPONDING #( keys )
    RESULT DATA(calculators)
    FAILED DATA(read_failed).

    IF calculators IS NOT INITIAL.

      TRY.
          DATA(is_result) = abap_false.
          LOOP AT calculators INTO DATA(zrec).
            DATA(is_calc) = abap_false.
            CASE zrec-Operator.
              WHEN '/'.
                zrec-CalcResult = zrec-OperandA / zrec-OperandB.
                is_calc = abap_true.
              WHEN '*'.
                zrec-CalcResult = zrec-OperandA * zrec-OperandB.
                is_calc = abap_true.
              WHEN '+'.
                zrec-CalcResult = zrec-OperandA + zrec-OperandB.
                is_calc = abap_true.
              WHEN '-'.
                zrec-CalcResult = zrec-OperandA - zrec-OperandB.
                is_calc = abap_true.
            ENDCASE.
            IF is_calc = abap_true.
              calculators[ %tky = zrec-%tky ]-CalcResult = zrec-CalcResult.
              is_result = abap_true.
            ENDIF.
          ENDLOOP.
          IF is_result = abap_true.
            MODIFY ENTITIES OF zml_r_calculator IN LOCAL MODE
           ENTITY Calculator
             UPDATE SET FIELDS
             WITH VALUE #( FOR calculator IN calculators
              ( %key    = calculator-%key
                %is_draft = calculator-%is_draft
                CalcResult = calculator-CalcResult
              ) )
         REPORTED DATA(update_reported).
            reported = CORRESPONDING #( DEEP update_reported ).
          ENDIF.
        CATCH cx_root INTO DATA(exception).
      ENDTRY.
    ENDIF.


  ENDMETHOD.

ENDCLASS.
