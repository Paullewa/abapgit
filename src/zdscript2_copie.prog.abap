REPORT ZDSCRIPT2_COPIE.

PARAMETERS: P_connid TYPE sbook-connid.


TYPES: BEGIN OF ty_sbook,
       connid type sbook-connid,
       customid TYPE sbook-customid,
       custtype TYPE sbook-custtype,
      passname TYPE sbook-passname,

    END OF ty_sbook.

data: wa_sbook TYPE ty_sbook,
      it_sbook TYPE TABLE OF ty_sbook.

TYPES: BEGIN OF Ty_sbf,      " sbook + sflight
*       carrid TYPE sbook-carrid,
       connid TYPE sbook-connid,
       fldate TYPE sbook-fldate,
*       custtype TYPE sbook-custtype,
       passname TYPE sbook-passname,
       planetype TYPE sflight-planetype,
       price    type sflight-price,
       END OF Ty_sbf.
DATA: WA_sbf TYPE Ty_sbf,
     it_wa_sbf type TABLE OF Ty_sbf.

*SELECT   b~connid, b~fldate , b~passname  ,f~planetype, f~price
*   from  sbook as b
*   LEFT OUTER JOIN sflight as f
*      on  f~connid = b~connid
**      and b~fldate = @p_date
*     where b~connid = @p_connid
*INTO @wa_sbf.
*ENDSELECT.


SELECT   b~connid, b~fldate , b~passname  ,f~planetype, f~price
   from  sbook as b
   LEFT OUTER JOIN sflight as f
      on  f~connid = b~connid
**      and b~fldate = @p_date
     where b~connid = @p_connid
INTO TABLE @it_wa_sbf.






select single connid customid  passname custtype
       FROM sbook INTO wa_sbook
       WHERE connid = p_connid.



if sy-subrc = 0.
  CALL FUNCTION 'OPEN_FORM'
   EXPORTING
     FORM                              = 'ZDFORM2 '.
  CALL FUNCTION 'WRITE_FORM'
EXPORTING
     ELEMENT                        = 'E1'

     WINDOW                         = 'SBOOK'.

  CALL FUNCTION 'WRITE_FORM'
EXPORTING
     ELEMENT                        = 'E1'

     WINDOW                         = 'LOGO'.
    CALL FUNCTION 'WRITE_FORM'
EXPORTING
     ELEMENT                        = 'E1'

     WINDOW                         = 'TEXT'.

  CALL FUNCTION 'WRITE_FORM'
EXPORTING
     ELEMENT                        = 'E1'

     WINDOW                         = 'BARCODE'.
LOOP at it_wa_sbf INTO wa_sbf.

    CALL FUNCTION 'WRITE_FORM'
EXPORTING
     ELEMENT                        = 'E1'

     WINDOW                         = 'MAIN'.

  ENDLOOP.


  CALL FUNCTION 'CLOSE_FORM'.
  ELSE.
    MESSAGE ' Es wurde keine Kunde gefunden ! ' TYPE 'I'.
 ENDIF.
