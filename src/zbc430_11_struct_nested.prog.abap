*&---------------------------------------------------------------------*
*& Report ZBC430_11_STRUCT_NESTED
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZBC430_11_STRUCT_NESTED.
*Replace ## by Your group- or screen number and
*uncomment the ABAP-coding
DATA wa_person TYPE zperson11.
START-OF-SELECTION.
 wa_person-name-firstname = 'Harry'.
 wa_person-name-lastname = 'Potter'.
 wa_person-street = 'Privet Drive'.
 wa_person-nr = '3'.
 wa_person-zip = 'GB-10889'.
 wa_person-city = 'London'.
 WRITE: / wa_person-name-firstname ,
 wa_person-name-lastname ,
 wa_person-street ,
 wa_person-nr ,
 wa_person-zip ,
 wa_person-city .
