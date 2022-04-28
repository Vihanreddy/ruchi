*&---------------------------------------------------------------------*
*& Report ZBC400_11_LOOP
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT bc400_its_itab_loop.
DATA: gt_connections TYPE bc400_t_connections,
 gs_connection TYPE bc400_s_connection.
* Get data
TRY.
 CALL METHOD cl_bc400_flightmodel=>get_connections
 IMPORTING
 et_connections = gt_connections.
 CATCH cx_bc400_no_data .
 WRITE: / 'No data found!'(ndf).
ENDTRY.
SORT gt_connections ASCENDING BY deptime.
* Output
LOOP AT gt_connections INTO gs_connection.
 WRITE: / gs_connection-carrid,
 gs_connection-connid,
 gs_connection-cityfrom,
 gs_connection-airpfrom,
 gs_connection-cityto,
 gs_connection-airpto,
 gs_connection-fltime,
 gs_connection-deptime,
 gs_connection-arrtime.
ENDLOOP.
