*&---------------------------------------------------------------------*
*& Report ZRTRAVEL_FLIGHT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZRTRAVEL_FLIGHT.

PARAMETERS  p_conid TYPE  spfli-connid.


CLASS zcl_travel_flight DEFINITION .

  PUBLIC SECTION.

   INTERFACES ZINTERFACE_TRAVEL.
   PRIVATE SECTION.
   data lv_connid TYPE spfli-connid.
*   METHODS ZINTERFACE_TRAVEL


ENDCLASS.



CLASS zcl_travel_flight IMPLEMENTATION.

METHOD ZINTERFACE_TRAVEL~select_all_entries .

data lv_connid TYPE spfli-connid.
     lv_connid = lv_connid.

SELECT    sp~mandt sp~carrid sp~connid
          s~fldate s~PASSFORM s~PASSNAME s~PASSBIRTH
          s~CLASS sp~COUNTRYFR sp~CITYFROM sp~CITYTO
          s~AGENCYNUM s~INVOICE sp~DEPTIME sp~ARRTIME
          sp~DISTANCE
FROM ( sbook as s
INNER JOIN spfli AS sp ON s~carrid = sp~carrid )
INTO  table ZINTERFACE_TRAVEL~it_sb
 WHERE sp~connid = ip_connid .
cl_demo_output=>display( ZINTERFACE_TRAVEL~it_sb ).
Write: / 'The number is'.
endmethod.
ENDCLASS.

data oref TYPE REF TO zcl_travel_flight.

START-OF-SELECTION.
create OBJECT oref.
oref->ZINTERFACE_TRAVEL~select_all_entries( ip_connid = p_conid ).
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
