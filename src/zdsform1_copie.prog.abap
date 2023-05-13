REPORT ZDSFORM1_COPIE.
* FM Name = /1BCDWB/SF00000001 # SMARTFORMS NAME : ZDSFORMS1

* Not recommended way of  calling the smart form.
CALL FUNCTION '/1BCDWB/SF00000001'.

* Recommanded way of calling smart forms

DATA V_FM TYPE RS38L_FNAM.

CALL FUNCTION 'SSF_FUNCTION_MODULE_NAME'
  EXPORTING
    formname                 = 'ZDSFORMS1'
 IMPORTING
   FM_NAME                  = V_FM.

CALL FUNCTION V_FM.
