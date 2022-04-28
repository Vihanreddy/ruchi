*&---------------------------------------------------------------------*
*& Report ZBC430_11_DATA_ELEMENTS1
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZBC430_11_DATA_ELEMENTS1.
*Replace ## by Your Group- Screennumber and uncomment
*the ABAP-coding
DATA: result TYPE zassets11.
PARAMETERS: pa_fname TYPE zfirstname11,
 pa_lname TYPE zlastname11,
 pa_activ TYPE zassets11,
 pa_liabs TYPE zliabilities11.
START-OF-SELECTION.
 NEW-LINE.
 WRITE: 'Client:', pa_fname, pa_lname.
 result = pa_activ - pa_liabs.
 NEW-LINE.
 WRITE: 'Finance:', pa_activ, pa_liabs, result.
