*&---------------------------------------------------------------------*
*& Report ZR_CROSS1
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZR_CROSS4_COPIE.

PARAMETERs p_empno TYPE i.

data: v_ename(10) TYPE c,
      v_empdes(10) TYPE c.

WRITE :/ 'Hello Rohit signt '.

CALL FUNCTION 'ZR_FM1'
DESTINATION 'ZR_RFC1'
  EXPORTING
    ip_empno        = p_empno
 IMPORTING
   EP_ENAME        = v_ename
   EP_EMPDES       = v_empdes.
 WRITE :/ ' Employee name is :' , v_ename,
        / ' Employee des is : ' , v_empdes.
