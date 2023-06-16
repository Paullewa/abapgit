REPORT ZSCRIPTT.
PARAMETERS p_conid TYPE sbook-connid.
DATA: d_carrid TYPE zbook_spfli-carrid.

d_carrid = p_conid.
types:
    BEGIN OF ty_sb,
      mandt     TYPE MANDT,
      carrid    TYPE S_CARR_ID,
      connid    TYPE S_CONN_ID,
      fldate    TYPE DATS,
      passname  TYPE S_PASSNAME,

      countryfr TYPE LAND1,
      cityfrom  TYPE S_FROM_CIT,
      cityto    TYPE S_TO_CITY,
      agencynum TYPE S_AGNCYNUM,

      deptime   TYPE S_DEP_TIME,
      arrtime   TYPE S_ARR_TIME,
      distance  TYPE ZQUAN,
    END OF ty_sb .

 DATA: it_zbook_spfli TYPE TABLE OF ty_sb,
           WA_SB type TY_SB ,
          lv_connid      TYPE spfli-connid,
          wa_zbfli       TYPE ty_sb,
          wa_print       TYPE itcpo.    " Form Druckausgabe aus Druckansicht
          wa_print-tdpreview = 'X'.
          wa_print-tddest = 'LP01'.
          lv_connid = lv_connid.
***************  Joining two table  spfli und sbook**************
*    SELECT    sp~mandt sp~carrid sp~connid
*              s~fldate  s~passname
*               sp~countryfr sp~cityfrom sp~cityto
*              s~agencynum  sp~deptime sp~arrtime
*              sp~distance
*    FROM ( sbook AS s
*    INNER JOIN spfli AS sp ON s~carrid = sp~carrid )

*    SELECT mandt carrid connid fldate passname countryfr cityfrom cityto
*           agencynum deptime arrtime distance
*    FROM  zbook_spfli
*    INTO TABLE it_zbook_spfli    """"  return the value inside a internal table
*    WHERE connid = p_conid .
*
*
*    SELECT SINGLE  mandt carrid connid fldate passname countryfr cityfrom cityto
*          agencynum deptime arrtime distance
*    FROM  zbook_spfli
*    INTO wa_sb
*          """"  return the value inside a internal table
*    WHERE connid = p_conid .


******************** Form Implementation ****************************


*    CALL FUNCTION 'OPEN_FORM'
*      EXPORTING
*        form    = 'ZDFORMF'
*        options = wa_print.
************  1st Element ************************
*
*  LOOP AT it_zbook_spfli INTO wa_sb.
*      CALL FUNCTION 'WRITE_FORM'
*        EXPORTING
*          element = 'E1'
*          FUNCTION   = 'SET'
*          TYPE       = 'BODY'
*          window  = 'MAIN'.
*    ENDLOOP.
*    CALL FUNCTION 'CLOSE_FORM'.
*ENDLOOP.
CALL FUNCTION 'OPEN_FORM'.

CALL FUNCTION 'START_FORM'
 EXPORTING
  form    = 'ZDFORMF'.

CALL FUNCTION 'WRITE_FORM'
EXPORTING
   element    = 'E1'
   "FUNCTION   = 'SET'
   "TYPE       = 'BODY'
   window     = 'MAIN'.
CALL FUNCTION 'END_FORM'.
CALL FUNCTION 'CLOSE_FORM'.

FORM GET_FLIGHT_DETAILS TABLES it_zbook_spfli STRUCTURE itcsy
          out_tab STRUCTURE itcsy.
DATA: ls TYPE zbook_spfli.
IF it_zbook_spfli IS NOT INITIAL.
  READ TABLE it_zbook_spfli INDEX 1.
  IF it_zbook_spfli-name = 'D_CARRID'.
  SELECT SINGLE * FROM  zbook_spfli INTO ls WHERE carrid = it_zbook_spfli-value.
  ENDIF.
ENDIF.
IF ls IS NOT INITIAL.
 READ TABLE out_tab INDEX 1.
 IF sy-subrc = 0.
   out_tab-value = ls-carrid.
   MODIFY out_tab INDEX 1.
  ENDIF.
 READ TABLE out_tab INDEX 2.
 IF sy-subrc = 0.
    out_tab-value = ls-connid.
    MODIFY out_tab INDEX 2.
  ENDIF.
 READ TABLE out_tab INDEX 3.
 IF sy-subrc = 0.
    out_tab-value = ls-cityfrom.
    MODIFY out_tab INDEX 3.
  ENDIF.
 READ TABLE out_tab INDEX 4.
 IF sy-subrc = 0.
    out_tab-value = ls-cityto.
    MODIFY out_tab INDEX 4.
  ENDIF.
 READ TABLE out_tab INDEX 5.
 IF sy-subrc = 0.
    out_tab-value = ls-countryfr.
    MODIFY out_tab INDEX 5.
  ENDIF.
 READ TABLE out_tab INDEX 6.
 IF sy-subrc = 0.
    out_tab-value = ls-cityto.
    MODIFY out_tab INDEX 6.
  ENDIF.
 READ TABLE out_tab INDEX 7.
 IF sy-subrc = 0.
    out_tab-value = ls-deptime.
    MODIFY out_tab INDEX 7.
  ENDIF.
 READ TABLE out_tab INDEX 8.
 IF sy-subrc = 0.
    out_tab-value = ls-distance.
    MODIFY out_tab INDEX 8.
  ENDIF.
ENDIF.
ENDFORM.
