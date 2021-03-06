*&---------------------------------------------------------------------*
*& Report ZBC430_11_ITAB_SORTED
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZBC430_11_ITAB_SORTED.
**Replace ## by Your group- or screennumber and
**uncomment the ABAP-coding
DATA it_flight TYPE zit_sflight11.
DATA wa_sflight TYPE sflight.
WRITE / 'Printout in tableorder of Database:'.
* Array fetch
SELECT * FROM sflight
 INTO wa_sflight
 WHERE carrid = 'JL'.
 WRITE: / wa_sflight-carrid,
 wa_sflight-connid,
 wa_sflight-fldate,
 wa_sflight-price,
 wa_sflight-currency,
 wa_sflight-planetype.
ENDSELECT.
ULINE.
SELECT * FROM sflight
 INTO TABLE it_flight
 WHERE carrid = 'JL'.
WRITE / 'Printout in tableorder of sorted ITAB:'.
LOOP AT it_flight INTO wa_sflight.
 WRITE: / wa_sflight-carrid,
 wa_sflight-connid,
 wa_sflight-fldate,
 wa_sflight-price,
 wa_sflight-currency,
 wa_sflight-planetype.
ENDLOOP.
