REPORT zrtravel_flight.
INCLUDE zincl_travel_flight.        "****** Include for Paramters***********
TABLES sscrfields.


CLASS zcl_travel_flight DEFINITION .

  PUBLIC SECTION.
    INTERFACES zinterface_travel.    "* call interface ***
*     types:
*    BEGIN OF ty_sb,
*      mandt     TYPE MANDT,
*      carrid    TYPE S_CARR_ID,
*      connid    TYPE S_CONN_ID,
*      fldate    TYPE DATS,
*      passname  TYPE S_PASSNAME,
*
*      countryfr TYPE LAND1,
*      cityfrom  TYPE S_FROM_CIT,
*      cityto    TYPE S_TO_CITY,
*      agencynum TYPE S_AGNCYNUM,
*
*      deptime   TYPE S_DEP_TIME,
*      arrtime   TYPE S_ARR_TIME,
*      distance  TYPE ZQUAN,
*    END OF ty_sb .
    DATA: it_zbook_spfli TYPE TABLE OF zinterface_travel~ty_sb.
*           WA_SB type TY_SB ,
*          lv_connid      TYPE spfli-connid,
*          wa_zbfli       TYPE ty_sb,
*          wa_print       TYPE itcpo.    " Form Druckausgabe aus Druckansicht


ENDCLASS.

CLASS zcl_travel_flight IMPLEMENTATION.
 METHOD zinterface_travel~select_all_entries.

***************  Joining two table  spfli und sbook**************
*    SELECT    sp~mandt sp~carrid sp~connid
*              s~fldate  s~passname
*               sp~countryfr sp~cityfrom sp~cityto
*              s~agencynum  sp~deptime sp~arrtime
*              sp~distance
*    FROM ( sbook AS s
*    INNER JOIN spfli AS sp ON s~carrid = sp~carrid )

    SELECT mandt carrid connid fldate passname countryfr cityfrom cityto
           agencynum deptime arrtime distance
    FROM  zbook_spfli
    INTO TABLE it_zbook_spfli.    """"  return the value inside a internal table
*    WHERE connid = p_conid .


PERFORM selectentriees USING p_conid.
 cl_demo_output=>display( it_zbook_spfli ).
**    SELECT SINGLE  mandt carrid connid fldate passname countryfr cityfrom cityto
**          agencynum deptime arrtime distance
**    FROM  zbook_spfli
**    INTO wa_sb
**          """"  return the value inside a internal table
**    WHERE connid = p_conid .
**
**
********************** Form Implementation ****************************
**
**
**    CALL FUNCTION 'OPEN_FORM'
**      EXPORTING
**        form    = 'ZDFORMT'
**        options = wa_print.
*************  1st Element ************************
**
**  LOOP AT it_zbook_spfli INTO wa_sb.
**      CALL FUNCTION 'WRITE_FORM'
**        EXPORTING
**          element = 'E1'
**          window  = 'MAIN'.
**    ENDLOOP.
**    CALL FUNCTION 'CLOSE_FORM'.
**     cl_demo_output=>display( it_zbook_spfli ).
ENDMETHOD.
*ENDLOOP.
*
**** Select all *********************************************
*  METHOD zinterface_travel~select_all_entries .
*
*    DATA: it_zbook_spfli TYPE TABLE OF zinterface_travel~ty_sb,
*          lv_connid      TYPE spfli-connid,
*          wa_zbfli       TYPE zinterface_travel~ty_sb,
*          wa_print       TYPE itcpo.    " Form Druckausgabe aus Druckansicht
*          wa_print-tdpreview = 'X'.
*          wa_print-tddest = 'LP01'.
*          lv_connid = lv_connid.
****************  Joining two table  spfli und sbook**************
**    SELECT    sp~mandt sp~carrid sp~connid
**              s~fldate  s~passname
**               sp~countryfr sp~cityfrom sp~cityto
**              s~agencynum  sp~deptime sp~arrtime
**              sp~distance
**    FROM ( sbook AS s
**    INNER JOIN spfli AS sp ON s~carrid = sp~carrid )
*
*    SELECT mandt carrid connid fldate passname countryfr cityfrom cityto
*           agencynum deptime arrtime distance
*    FROM  zbook_spfli
*    INTO TABLE zinterface_travel~it_zbook_spfli    """"  return the value inside a internal table
*    WHERE connid = ip_connid .
*
*
*    SELECT SINGLE  mandt carrid connid fldate passname countryfr cityfrom cityto
*          agencynum deptime arrtime distance
*    FROM  zbook_spfli
*    INTO zinterface_travel~wa_sb
*          """"  return the value inside a internal table
*    WHERE connid = ip_connid .
*
*
********************* Form Implementation ****************************
*
*
*    CALL FUNCTION 'OPEN_FORM'
*      EXPORTING
*        form    = 'ZDFORMT'
*        options = wa_print.
************  1st Element ************************
*
*  LOOP AT zinterface_travel~it_zbook_spfli INTO zinterface_travel~wa_sb.
*      CALL FUNCTION 'WRITE_FORM'
*        EXPORTING
*          element = 'E1'
*          window  = 'MAIN'.
*    ENDLOOP.
*    CALL FUNCTION 'CLOSE_FORM'.
**ENDLOOP.
*
********************* End Form Implementation ***************************
*    cl_demo_output=>display( zinterface_travel~it_zbook_spfli ).


*** Select single ***********************************************
  METHOD zinterface_travel~select_single_entries .

*    DATA lv_passnme TYPE sbook-passname.
*    lv_connid = lv_connid.

    SELECT SINGLE  mandt carrid connid fldate  passname
                   countryfr cityfrom cityto agencynum
                   deptime arrtime distance
             FROM zbook_spfli
             INTO  zinterface_travel~wa_sb   """"  return the value inside a workarea
             WHERE connid = i_connid
               AND passname = i_passname .
    IF sy-subrc = 0.
*
*    SELECT  SINGLE  sp~mandt sp~carrid sp~connid
*              s~fldate  s~passname
*               sp~countryfr sp~cityfrom sp~cityto
*              s~agencynum sp~deptime sp~arrtime
*              sp~distance
*    FROM ( sbook AS s
*    INNER JOIN spfli AS sp ON s~carrid = sp~carrid )
*    INTO  zinterface_travel~wa_sb
*     WHERE sp~connid = ip_connid .
*    IF sy-subrc = 0.


******************** BADI Implementation ************************
ENHANCEMENT-POINT zbadi_sbpfl SPOTS zbadi_sbpfl_impl .

******************* End BADI Implementation ************************

 IF sy-subrc <> 0.
* Implement suitable error handling here
ENDIF.
     cl_demo_output=>display( zinterface_travel~wa_sb ).
ELSE.
     WRITE: / 'An error occured during th execution of the Program'.
     ULINE.
     WRITE: / 'Please contact the administrator'.
ENDIF.
ENDMETHOD.


*** Sort Entries ********************************************
  METHOD zinterface_travel~sort_entries .
    DATA lv_connid TYPE spfli-connid.
    lv_connid = lv_connid.

    SELECT    sp~mandt sp~carrid sp~connid
              s~fldate  s~passname
               sp~countryfr sp~cityfrom sp~cityto
              s~agencynum sp~deptime sp~arrtime
              sp~distance
    FROM ( sbook AS s
    INNER JOIN spfli AS sp ON s~carrid = sp~carrid )
    INTO TABLE zinterface_travel~it_sb
     WHERE sp~connid = p_conid .
    SORT zinterface_travel~it_sb.
    IF sy-subrc = 0.
      cl_demo_output=>display( zinterface_travel~it_sb ).
    ELSE.
      WRITE: / 'An error occured during th execution of the Program'.
      ULINE.
      WRITE: / 'Please contact the administrator'.
    ENDIF.

  ENDMETHOD.

****************** insert entries****************************
  METHOD zinterface_travel~insert_entries.

    IF sy-subrc = 0.
      MOVE p_mandt TO zinterface_travel~wa_sb-mandt.
      MOVE p_conid  TO zinterface_travel~wa_sb-connid.
      MOVE p_carrid  TO zinterface_travel~wa_sb-carrid.
      MOVE p_fdate  TO zinterface_travel~wa_sb-fldate.
      MOVE p_pname  TO zinterface_travel~wa_sb-passname.
      MOVE p_ctryfr  TO zinterface_travel~wa_sb-countryfr.
      MOVE p_cfro  TO zinterface_travel~wa_sb-cityfrom.
      MOVE p_cto  TO zinterface_travel~wa_sb-cityto.
      MOVE p_agnum  TO zinterface_travel~wa_sb-agencynum.
      MOVE p_dtime  TO zinterface_travel~wa_sb-deptime.
      MOVE p_atime  TO zinterface_travel~wa_sb-arrtime.
      MOVE p_dist  TO zinterface_travel~wa_sb-distance.
*INSERT INTO  zinterface_travel~it_sb VALUES zinterface_travel~wa_sb.
*APPEND zinterface_travel~wa_sb to zinterface_travel~it_sb.
      INSERT INTO zbook_spfli VALUES zinterface_travel~wa_sb.
*INSERT zinterface_travel~wa_sb INTO   zinterface_travel~it_sb  .
      IF sy-subrc = 0.
        MESSAGE s000(ztravelmsm) .
*        APPEND zinterface_travel~wa_sb TO zinterface_travel~it_sb.
*        APPEND zinterface_travel~wa_sb TO zinterface_travel~it_zbook_spfli.
* Copying internal table(it_sb) to another Table( it_zbook_spfli)
*zinterface_travel~it_sb[] = zinterface_travel~it_ZBOOK_SPFLI[].

*        cl_demo_output=>display( zinterface_travel~it_zbook_spfli ).
      ELSE.
        MESSAGE s001(ztravelmsm).
      ENDIF.

    ELSE.
      WRITE: / ' Insert Error 2'.
    ENDIF.
    CLEAR zinterface_travel~wa_sb.


  ENDMETHOD.

ENDCLASS.
*'''''''''''''''''''''''''''
INITIALIZATION.

  btn0 = 'SELECT'.
  btn1 = 'INSERT'.
  btn2 = 'UPDATE'.
  btn3 = 'DELETE'.
AT SELECTION-SCREEN ON BLOCK b1.
*text of the buttons so that it can be translated
  IF sscrfields-ucomm EQ 'CLI0' OR
      sscrfields-ucomm EQ 'CLI1' OR
      sscrfields-ucomm EQ 'CLI2'.
    sscrfields-ucomm = 'ONLI'. " Finge que carregou em F8. Belo truque ;)
  ENDIF.
*'''''''''''''''''''''
*DATA oref TYPE REF TO zcl_travel_flight.

START-OF-SELECTION.
DATA oref TYPE REF TO zcl_travel_flight.
  CREATE OBJECT oref.
 CASE sscrfields-ucomm.
    WHEN 'cli0'.
      CALL METHOD oref->zinterface_travel~select_all_entries( ip_connid = p_conid ).
*      oref->zinterface_travel~select_all_entries( ip_connid = p_conid ).
    WHEN 'cli1'.
      WRITE 'Carregaste no '.
    WHEN 'cli02'.
      WRITE 'Carregaste no botão de baixo'.
ENDCASE.

*oref->zinterface_travel~select_all_entries( ip_connid = p_conid ).
*ENDIF.
*oref->ZINTERFACE_TRAVEL~select_single_entries( i_connid = p_conid
*                                             i_passname = p_pname ).
*oref->zinterface_travel~sort_entries( ip_connid = p_conid ).

* oref->zinterface_travel~insert_entries(
*    EXPORTING
*      ip_mandt     = p_mandt
*      ip_carrid    = p_carrid
*      ip_connid    = p_conid
*      ip_fldate    = p_fdate
*      ip_passname  = p_pname
*      ip_countryfr = p_ctryfr
*      ip_cityfrom  = p_cfro
*      ip_cityto    = p_cto
*      ip_agencynum = p_agnum
*      ip_deptime   = p_dtime
*      ip_arrtime   = p_atime
*      ip_distance  = p_dist
*RECEIVING
*   rt_flight    =
*).





FORM selectentriees USING i_conid TYPE sbook-connid.
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
          wa_print       TYPE itcpo.
     wa_print-tdpreview = 'X'.
          wa_print-tddest = 'LP01'.
          lv_connid = lv_connid.
          SELECT SINGLE  mandt carrid connid fldate passname countryfr cityfrom cityto
          agencynum deptime arrtime distance
    FROM  zbook_spfli
    INTO wa_sb
          """"  return the value inside a internal table
    WHERE connid = i_conid .


******************** Form Implementation ****************************


    CALL FUNCTION 'OPEN_FORM'
      EXPORTING
        form    = 'ZDFORMT'
        options = wa_print.
***********  1st Element ************************

  LOOP AT it_zbook_spfli INTO wa_sb.
      CALL FUNCTION 'WRITE_FORM'
        EXPORTING
          element = 'E1'
          window  = 'MAIN'.
    ENDLOOP.
    CALL FUNCTION 'CLOSE_FORM'.
ENDFORM.
