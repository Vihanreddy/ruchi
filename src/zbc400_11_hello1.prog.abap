*&---------------------------------------------------------------------*
*& Report ZBC400_11_HELLO1
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZBC400_11_HELLO1.
PARAMETERS: pa_name TYPE string.
WRITE 'Hello World!'.
NEW-LINE.
WRITE: 'Hello',
 pa_name.
