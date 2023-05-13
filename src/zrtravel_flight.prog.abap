*&---------------------------------------------------------------------*
*& Report ZRTRAVEL_FLIGHT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zrtravel_flight.
PARAMETERS: p_mandt  TYPE spfli-mandt,
            p_conid  TYPE  spfli-connid  OBLIGATORY,
            p_carrid TYPE spfli-carrid,
            p_fdate  TYPE sbook-fldate,
            p_pname  TYPE sbook-passname,
            p_ctryfr TYPE spfli-countryfr,
            p_cfro   TYPE spfli-cityfrom,
            p_cto    TYPE  spfli-cityto,
            p_agnum  TYPE sbook-agencynum,
            p_dtime  TYPE spfli-deptime,
            p_atime  TYPE spfli-arrtime,
            p_dist   TYPE spfli-distance.


CLASS zcl_travel_flight DEFINITION .

  PUBLIC SECTION.
* call interface ***
    INTERFACES zinterface_travel.
  PRIVATE SECTION.

    DATA:lv_mandt     TYPE spfli-mandt,
         lv_carrid    TYPE spfli-carrid,
         lv_connid    TYPE spfli-connid,
         lv_fldate    TYPE sbook-fldate,
         lv_passname  TYPE sbook-passname,
         lv_passbirth TYPE sbook-passbirth,
         lv_class     TYPE sbook-class,
         lv_countryfr TYPE spfli-countryfr,
         lv_cityfrom  TYPE spfli-cityfrom,
         lv_cityto    TYPE spfli-cityto,
         lv_agencynum TYPE sbook-agencynum,
         lv_invoice   TYPE sbook-invoice,
         lv_deptime   TYPE spfli-deptime,
         lv_arrtime   TYPE spfli-arrtime,
         lv_distance  TYPE spfli-distance.

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
*oref->ZINTERFACE_TRAVEL~select_all_entries( ip_connid = p_conid ).
*oref->ZINTERFACE_TRAVEL~select_single_entries( ip_connid = p_conid ).
*oref->zinterface_travel~sort_entries( ip_connid = p_conid ).

  oref->zinterface_travel~insert_entries(
    EXPORTING
      ip_mandt     = p_mandt
      ip_carrid    = p_carrid
      ip_connid    = p_conid
      ip_fldate    = p_fdate
      ip_passname  = p_pname
      ip_countryfr = p_ctryfr
      ip_cityfrom  = p_cfro
      ip_cityto    = p_cto
      ip_agencynum = p_agnum
      ip_deptime   = p_dtime
      ip_arrtime   = p_atime
      ip_distance  = p_dist
*  RECEIVING
*    rt_flight    =
  ).

























*oref->sele(ct_all_entries( iv_connid = p_conid   )



*
*    TYPES: BEGIN OF ty_sb,
*         mandt TYPE spfli-mandt,
*         carrid type spfli-carrid,
*         connid type spfli-connid,
*         FLDATE type sbook-FLDATE,
*         PASSNAME type sbook-passname,
*         PASSBIRTH type sbook-PASSBIRTH,
*         CLASS type sbook-CLASS,
*         COUNTRYFR type spfli-COUNTRYFR,
*         CITYFROM type spfli-CITYFROM,
*         CITYTO type spfli-CITYTO,
*         AGENCYNUM type sbook-AGENCYNUM,
*         INVOICE type sbook-INVOICE,
*         DEPTIME TYPE spfli-DEPTIME,
*         ARRTIME type spfli-ARRTIME,
*         DISTANCE type spfli-DISTANCE,
*   END OF ty_sb.
*   DATA:
*       wa_sb TYPE ty_sb,      " work area
*       it_sb TYPE TABLE OF ty_sb."  intern table
*
*    PARAMETERS  p_conid TYPE  spfli-connid.
*CLASS zcl_travel_flight2 DEFINITION .
*
*  PUBLIC SECTION.
*
*  METHODS select_all_entries IMPORTING iv_connid TYPE spfli-connid
*          RETURNING VALUE(rt_flight) TYPE ty_sb  .
*  PRIVATE SECTION.
*  data lv_connid TYPE spfli-connid.
*
*
*ENDCLASS.
*
*
*CLASS zcl_travel_flight2 IMPLEMENTATION.
*
*METHOD select_all_entries .
*
*data lv_connid TYPE spfli-connid.
*     lv_connid = lv_connid.
*
*SELECT    sp~mandt sp~carrid sp~connid
*          s~fldate s~PASSNAME s~PASSBIRTH
*          s~CLASS sp~COUNTRYFR sp~CITYFROM sp~CITYTO
*          s~AGENCYNUM s~INVOICE sp~DEPTIME sp~ARRTIME
*          sp~DISTANCE
*FROM ( sbook as s
*INNER JOIN spfli AS sp ON s~carrid = sp~carrid )
*INTO  table it_sb
* WHERE sp~connid = p_conid .
*cl_demo_output=>display( it_sb ).
*endmethod.
*ENDCLASS.

*data oref TYPE REF TO zcl_travel_flight2.
*
*START-OF-SELECTION.
*create OBJECT oref.
*
*oref->select_all_entries( iv_connid = p_conid   ).

** unit test class
*
*CLASS zltc_zcl_travel_flight2 DEFINITION FOR TESTING
*Duration short RISK LEVEL HARMLESS.
*PRIVATE SECTION.
*DATA mo_select_all TYPE REF TO zcl_travel_flight2.
*METHODS: setup,
*        select_all_entries ,
*        teardown.
*
*ENDCLASS.
*
*CLASS zltc_zcl_travel_flight2 IMPLEMENTATION.
*METHOD setup.
*create OBJECT mo_select_all.
*
*ENDMETHOD.
*METHOD select_all_entries.
*DATA: lv_expected TYPE  ty_sb,
*      itab TYPE  ty_sb.
* itab = mo_select_all->select_all_entries( iv_connid = p_conid ).
* cl_abap_unit_assert=>assert_equals(
*   EXPORTING
*     act                  = itab                           " Data object with current value
*     exp                  = lv_expected                            " Data object with expected type
*
* ).
*
*
*
*
*
*ENDMETHOD.
*
*METHOD teardown.
*clear mo_select_all.
*ENDMETHOD.
*
*
*ENDCLASS.
