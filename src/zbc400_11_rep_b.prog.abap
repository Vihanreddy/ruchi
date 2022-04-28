
*&--------------------------------------------
*& Report BC400_RPS_REP_B
*&--------------------------------------------
REPORT bc400_rps_rep_b.
TYPE-POOLS:
 icon,
 col.
CONSTANTS:
 gc_limit_red TYPE s_flghtocc VALUE 98,
 gc_limit_yellow TYPE s_flghtocc VALUE 75,
 gc_actvt_display TYPE activ_auth VALUE '03'.
DATA:
 gt_flights TYPE bc400_t_flights,
 gs_flight TYPE bc400_s_flight.
PARAMETERS:
 pa_car TYPE bc400_s_flight-carrid.
SELECT-OPTIONS:
 so_con FOR gs_flight-connid.
INITIALIZATION.
 pa_car = 'LH'.
AT SELECTION-SCREEN.
 TRY.
 CALL METHOD cl_bc400_flightmodel=>check_authority
 EXPORTING
 iv_carrid = pa_car
 iv_activity = gc_actvt_display.
 CATCH cx_bc400_no_auth .
 MESSAGE e046(bc400) WITH pa_car.
 ENDTRY.
START-OF-SELECTION.
 TRY.
 CALL METHOD cl_bc400_flightmodel=>get_flights_range
 EXPORTING
 iv_carrid = pa_car
 it_connid = so_con[] "brackets needed for so_con
 IMPORTING
 et_flights = gt_flights.
 CATCH cx_bc400_no_data.
   WRITE / 'No flights for the selected flight connection'(non).
 ENDTRY.
 LOOP AT gt_flights INTO gs_flight.
 NEW-LINE.
 IF gs_flight-percentage >= gc_limit_red.
 WRITE icon_red_light AS ICON.
 ELSEIF gs_flight-percentage >= gc_limit_yellow.
 WRITE icon_yellow_light AS ICON.
 ELSE.
 WRITE icon_green_light AS ICON.
 ENDIF.
 WRITE: gs_flight-carrid COLOR COL_KEY,
 gs_flight-connid COLOR COL_KEY,
 gs_flight-fldate COLOR COL_KEY,
 gs_flight-seatsmax,
 gs_flight-seatsocc,
 gs_flight-percentage.
  ENDLOOP.
