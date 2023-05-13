*&---------------------------------------------------------------------*
*& Report ZR_CROSS1
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZR_CROSS3_COPIE.

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
   EP_EMPDES       = v_empdes
 EXCEPTIONS
     SYSTEM_FAILURE        = 1
     COMMUNICATION_FAILURE = 2
     NOEMPLOYEE            = 3
     OTHERS                = 4.
    CASE SY-SUBRC.
      WHEN '1'.
        MESSAGE ' SYSTEM_FAILURE EXCEPTION RAISED ' TYPE 'I'.
      WHEN '2'.
        MESSAGE ' COMMUNICATION_FAILURE  EXCEPTION RAISE ' TYPE 'I'.
      WHEN '3'.
        MESSAGE ' NO EMPLOYEE NUMBER IS AVAILABLE ' TYPE 'I'.
      WHEN '4'.
        MESSAGE ' OTHER EXCEPTION RAISED ' TYPE 'I'.
  ENDCASE.
 WRITE :/ ' Employee name is :' , v_ename,
        / ' Employee des is : ' , v_empdes.
