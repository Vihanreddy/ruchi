*&---------------------------------------------------------------------*
*& Report ZBC400_11_COMPUTE2
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT bc400_mos_global_class_1 .
PARAMETERS:
 pa_int1 TYPE i,
 pa_op TYPE c LENGTH 1,
 pa_int2 TYPE i.
DATA gv_result TYPE p LENGTH 16 DECIMALS 2.
IF ( pa_op = '+' OR
 pa_op = '-' OR
 pa_op = '*' OR
 pa_op = '/' AND pa_int2 <> 0 OR
 pa_op = '%' OR
 pa_op = 'P' ).
 CASE pa_op.
 WHEN '+'.
 gv_result = pa_int1 + pa_int2.
 WHEN '-'.
 gv_result = pa_int1 - pa_int2.
 WHEN '*'.
 gv_result = pa_int1 * pa_int2.
 WHEN '/'.
 gv_result = pa_int1 / pa_int2.
 WHEN 'P'.
 TRY.
 CALL METHOD cl_bc400_compute=>get_power
 EXPORTING
 iv_base = pa_int1
 iv_power = pa_int2
 IMPORTING
 ev_result = gv_result.
 CATCH cx_bc400_power_too_high .
 WRITE 'Max value of Power is 4'(mvp).
 CATCH cx_bc400_result_too_high .
 WRITE 'Result value was too high'(rvh).
 ENDTRY.
 WHEN '%'.
 CALL FUNCTION 'BC400_MOS_PERCENTAGE'
 EXPORTING
 iv_act = pa_int1
 iv_max = pa_int2
 IMPORTING
 ev_percentage = gv_result
 EXCEPTIONS
 division_by_zero = 1
 OTHERS = 2.
 IF sy-subrc <> 0.
 WRITE 'Error in Function Module'(efm).
 ENDIF.
 ENDCASE.
 WRITE: 'Result:'(res), gv_result.
ELSEIF pa_op = '/' AND pa_int2 = 0.
 WRITE: 'No division by zero!'(dbz).
ELSE.
 WRITE: 'Invalid operator!'(iop).
ENDIF.
