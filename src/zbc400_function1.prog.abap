*&---------------------------------------------------------------------*
*& Report ZBC400_FUNCTION1
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT bc400_mos_function_module_1.
TYPES tv_result TYPE p LENGTH 16 DECIMALS 2.
PARAMETERS: pa_int1 TYPE i, pa_op TYPE c LENGTH 1,
 pa_int2 TYPE i.
DATA gv_result TYPE tv_result.
IF ( pa_op = '+' OR pa_op = '-' OR
 pa_op = '*' OR pa_op = '/' AND
 pa_int2 <> 0 OR pa_op = '%' OR
 pa_op = 'P').
 CASE pa_op.
 WHEN '+'.
 gv_result = pa_int1 + pa_int2.
 WHEN '-'.
 gv_result = pa_int1 - pa_int2.
 WHEN '*'.
 gv_result = pa_int1 * pa_int2.
 WHEN '/'.
 gv_result = pa_int1 / pa_int2.
 WHEN '%'.
 PERFORM calc_percentage USING pa_int1 pa_int2
 CHANGING gv_result.
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
 WRITE 'Max value of power is 4' (mvp).
 WHEN 2.
 WRITE 'Result value too high' (rvh).
 WHEN 3.
 WRITE 'Unknown error' (uer).
 ENDCASE.
 ENDCASE.
 WRITE: 'Result:'(res), gv_result.
ELSEIF pa_op = '/' AND pa_int2 = 0.
 WRITE: 'No division by zero!'(dbz).
ELSE.
 WRITE: 'Invalid operator!'(iop).
ENDIF.
*&-----------------------------------------------*
*& Form calc_percentage
*&-----------------------------------------------*
* calculate percentage value
*------------------------------------------------*
* -->PV_ACT actual value
* -->PV_MAX maximum value
* <--CV_RESULT result
*------------------------------------------------*
FORM calc_percentage USING pv_act TYPE i pv_max TYPE i
 CHANGING cv_result TYPE tv_result.
* Simple Error Handling
 IF pv_max = 0.
 cv_result = 0.
 WRITE 'WARNING!!! Error in percentage calculation'(epc).
 ELSE.
* Calculate result
 cv_result = pv_act / pv_max * 100.
 ENDIF.
ENDFORM. " calc_percentage
