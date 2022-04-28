*&----------------------------------------*
*& Report BC400_MOS_FUNCTION_MODULE_2
*&----------------------------------------*
REPORT bc400_mos_function_module_2.
PARAMETERS: pa_int1 TYPE i,
 pa_op TYPE c LENGTH 1,
 pa_int2 TYPE i.
DATA gv_result TYPE p LENGTH 16 DECIMALS 2.
IF ( pa_op = '+' OR pa_op = '-' OR
 pa_op = '*' OR pa_op = '/' AND
 pa_int2 <> 0 OR pa_op = '%' OR
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
 CALL FUNCTION 'BC400_MOS_POWER'
 EXPORTING
 iv_base = pa_int1
 iv_power = pa_int2
 IMPORTING
 ev_result = gv_result
 EXCEPTIONS
 power_value_too_high = 1
 result_value_too_high = 2
 OTHERS = 3.
 CASE sy-subrc.
 WHEN 0.
* no action needed
 WHEN 1.
 WRITE 'Max value of power is 4'(mvp).
 WHEN 2.
 WRITE 'Result value too high'(rvh).
 WHEN 3.
 WRITE 'Unknown error'(uer).
 ENDCASE.
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
WRITE 'Error in Function Module' .
 ENDIF.
 ENDCASE.
 WRITE: 'Result:'(res), gv_result.
ELSEIF pa_op = '/' AND pa_int2 = 0.
 WRITE: 'No division by zero!'(dbz).
ELSE.
 WRITE: 'Invalid operator!'(iop).
ENDIF.
* Source code extract from the function module:
*&------------------------------------------------
* IMPORTING
* REFERENCE(IV_ACT) TYPE BC400_ACT
* REFERENCE(IV_MAX) TYPE BC400_MAX
* EXPORTING
* REFERENCE(EV_PERCENTAGE) TYPE BC400_PERC
* EXCEPTIONS
* DIVISION_BY_ZERO
*&------------------------------------------------*
  * Error handling
 IF iv_max = 0.
 ev_percentage = 0.
 RAISE division_by_zero.
ELSE.
* Calculate result
 ev_percentage = iv_act / iv_max * 100.
 ENDIF.
ENDFUNCTION.
