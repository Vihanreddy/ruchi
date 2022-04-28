*&---------------------------------------------------------------------*
*& Report ZBC400_11_DEMO3
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZBC400_11_DEMO3.
PARAMETERS:   pa_int1 TYPE i,
              pa_op TYPE c LENGTH 1,
              pa_int2 TYPE i.
DATA gv_result TYPE p LENGTH 16 DECIMALS 2.

IF ( pa_op = '+' OR

  pa_op = '-' OR
 pa_op = '*' OR
 pa_op = '/' AND pa_int2 <> 0 ).
 CASE pa_op.
 WHEN '+'.
 gv_result = pa_int1 + pa_int2.
 WHEN '-'.
 gv_result = pa_int1 - pa_int2.
 WHEN '*'.
 gv_result = pa_int1 * pa_int2.
 WHEN '/'.
 gv_result = pa_int1 / pa_int2.
 ENDCASE.
 WRITE: 'Result'(res), gv_result.
ELSEIF pa_op = '/' AND pa_int2 = 0.
 WRITE 'No division by zero!'(dbz).
ELSE.
 WRITE 'Invalid operator!'(iop).

 ENDIF.
