*&---------------------------------------------------------------------*
*& Report ZBC400_11_DEMO
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT bc400_sts_structure.
PARAMETERS: pa_car TYPE bc400_s_flight-carrid,
 pa_con TYPE bc400_s_flight-connid,
 pa_date TYPE bc400_s_flight-fldate.
DATA: gs_carrier TYPE bc400_s_carrier,
 gs_flight TYPE bc400_s_flight.
TYPES: BEGIN OF ts_carrierflight,
 carrid TYPE bc400_s_flight-carrid,
 connid TYPE bc400_s_flight-connid,
 fldate TYPE bc400_s_flight-fldate,
 seatsmax TYPE bc400_s_flight-seatsmax,
 seatsocc TYPE bc400_s_flight-seatsocc,
 percentage TYPE bc400_s_flight-percentage,
 carrname TYPE bc400_s_carrier-carrname,
 currcode TYPE bc400_s_carrier-currcode,
 url TYPE bc400_s_carrier-url,
 END OF ts_carrierflight.
DATA: gs_carrierflight TYPE ts_carrierflight.
* Get data
TRY.
 CALL METHOD cl_bc400_flightmodel=>get_flight
 EXPORTING
 iv_carrid = pa_car
 iv_connid = pa_con
 iv_fldate = pa_date
 IMPORTING
 es_flight = gs_flight.
 CALL METHOD cl_bc400_flightmodel=>get_carrier
 EXPORTING
 iv_carrid = pa_car
 IMPORTING
 es_carrier = gs_carrier.
 CATCH cx_bc400_no_data .
 WRITE: 'No data found!'(ndf).
 CATCH cx_bc400_no_auth .
 WRITE: 'No authority for this carrier!'(nau).
ENDTRY.
* Fill gs_carrierflight
MOVE-CORRESPONDING gs_carrier TO gs_carrierflight.
MOVE-CORRESPONDING gs_flight TO gs_carrierflight.
IF gs_carrierflight IS NOT INITIAL.
 WRITE: / gs_carrierflight-carrid,
 gs_carrierflight-connid,
 gs_carrierflight-fldate,
 gs_carrierflight-carrname,
 gs_carrierflight-currcode,
 gs_carrierflight-seatsmax,
 gs_carrierflight-seatsocc,
 gs_carrierflight-percentage, '%',
 gs_carrierflight-url.
ENDIF.
