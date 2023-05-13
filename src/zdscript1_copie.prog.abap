REPORT ZDSCRIPT1_COPIE.

DATA: wa_print type ITCPO.
wa_print-tdpreview = 'X'.
wa_print-tddest = 'LP01'.


* CALL OPEN_FORM
CALL FUNCTION 'OPEN_FORM'
 EXPORTING
   dialog                            =' '
   FORM                              = 'ZDFORM1 '
   options                           = wa_print.

*CALL WRITE_FORM
CALL FUNCTION 'WRITE_FORM'
 EXPORTING
   WINDOW                         = 'MAIN'
   element                        ='E1'.
CALL FUNCTION 'WRITE_FORM'
 EXPORTING
   WINDOW                         = 'MAIN'
   element                        ='E2'.
CALL FUNCTION 'WRITE_FORM'
 EXPORTING
   WINDOW                         = 'FENSTER1'
   element                        ='E1'.

CALL FUNCTION 'WRITE_FORM'
 EXPORTING
   WINDOW                         = 'FENSTER2'
   element                        ='E1'.

* CALL CLOSE_FORM
CALL FUNCTION 'CLOSE_FORM'.
