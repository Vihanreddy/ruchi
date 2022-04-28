FUNCTION ZBC400_11_AUTH_CHECK.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     REFERENCE(IV_CARRID) TYPE  S_CARR_ID
*"     REFERENCE(IV_ACTIVITY) TYPE  ACTIV_AUTH
*"  EXCEPTIONS
*"      NO_AUTH
*"      WRONG_ACTIVITY
*"----------------------------------------------------------------------
CASE iv_activity.
 WHEN '01' OR '02' OR '03'.
 AUTHORITY-CHECK OBJECT 'S_CARRID'
          ID 'CARRID' FIELD iv_carrid
          ID 'ACTVT' FIELD iv_activity.
 IF sy-subrc <> 0.
    RAISE no_auth.
 ENDIF.
 WHEN OTHERS.
   RAISE wrong_activity.
   ENDCASE.

ENDFUNCTION.
