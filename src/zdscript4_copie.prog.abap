REPORT ZDSCRIPT4_COPIE.

PARAMETERS p_lang TYPE T002-spras.
CALL FUNCTION 'OPEN_FORM'
 EXPORTING
   FORM                              = 'ZDFORM31 '
   LANGUAGE                          = p_lang.

CALL FUNCTION 'WRITE_FORM'
 EXPORTING
   ELEMENT                        = 'E1'
   WINDOW                         = 'MAIN'.

CALL FUNCTION 'CLOSE_FORM'.
