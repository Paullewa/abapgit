*&---------------------------------------------------------------------*
*& Report ZRTRAVEL_FLIGHT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zrtravel_flight.

****** Include for Paramters***********
Include ZINCL_TRAVEL_FLIGHT.

CLASS zcl_travel_flight DEFINITION .

  PUBLIC SECTION.
* call interface ***
    INTERFACES zinterface_travel.

ENDCLASS.



CLASS zcl_travel_flight IMPLEMENTATION.

*** Select all *********************************************
  METHOD zinterface_travel~select_all_entries .

    DATA lv_connid TYPE spfli-connid.
    lv_connid = lv_connid.

    SELECT    sp~mandt sp~carrid sp~connid
              s~fldate  s~passname
               sp~countryfr sp~cityfrom sp~cityto
              s~agencynum  sp~deptime sp~arrtime
              sp~distance
    FROM ( sbook AS s
    INNER JOIN spfli AS sp ON s~carrid = sp~carrid )
    INTO  TABLE zinterface_travel~it_sb
     WHERE sp~connid = ip_connid .
    IF sy-subrc = 0.
      cl_demo_output=>display( zinterface_travel~it_sb ).
      APPEND zinterface_travel~wa_sb TO zinterface_travel~it_sb.
    ELSE.
      WRITE: / 'An error occured during th execution of the Program'.
      ULINE.
      WRITE: / 'Please contact the administrator'.
    ENDIF.
  ENDMETHOD.


*** Select single ***********************************************
  METHOD zinterface_travel~select_single_entries .

    DATA lv_connid TYPE spfli-connid.
    lv_connid = lv_connid.

    SELECT  SINGLE  sp~mandt sp~carrid sp~connid
              s~fldate  s~passname
               sp~countryfr sp~cityfrom sp~cityto
              s~agencynum sp~deptime sp~arrtime
              sp~distance
    FROM ( sbook AS s
    INNER JOIN spfli AS sp ON s~carrid = sp~carrid )
    INTO  zinterface_travel~wa_sb
     WHERE sp~connid = ip_connid .
    IF sy-subrc = 0.
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

*INSERT zinterface_travel~wa_sb INTO   zinterface_travel~it_sb  .
      IF sy-subrc = 0.
        WRITE: / ' ENTRIES SUCCESSFUL ADDED !!! '.
        APPEND zinterface_travel~wa_sb TO zinterface_travel~it_sb.
        cl_demo_output=>display( zinterface_travel~it_sb ).
      ELSE.
        WRITE: / ' Insert Error 1'.
      ENDIF.


    ELSE.
      WRITE: / ' Insert Error 2'.
    ENDIF.
    CLEAR zinterface_travel~wa_sb.


  ENDMETHOD.

ENDCLASS.

DATA oref TYPE REF TO zcl_travel_flight.

START-OF-SELECTION.
  CREATE OBJECT oref.
oref->ZINTERFACE_TRAVEL~select_all_entries( ip_connid = p_conid ).
*oref->ZINTERFACE_TRAVEL~select_single_entries( ip_connid = p_conid ).
*oref->zinterface_travel~sort_entries( ip_connid = p_conid ).

*  oref->zinterface_travel~insert_entries(
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
**  RECEIVING
**    rt_flight    =
*  ).
