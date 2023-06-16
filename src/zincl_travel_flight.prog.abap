**&---------------------------------------------------------------------*
**& Include ZINCL_TRAVEL_FLIGHT
**&---------------------------------------------------------------------*

*SELECTION-SCREEN BEGIN OF SCREEN 100 TITLE text-001.
SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE text-001.
PARAMETERS: p_mandt  TYPE spfli-mandt,
            p_conid  TYPE  spfli-connid   DEFAULT 0555,
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
           SELECTION-SCREEN SKIP 1.
           SELECTION-SCREEN PUSHBUTTON /30(10) btn0 USER-COMMAND cli0.
           SELECTION-SCREEN  PUSHBUTTON 45(10) btn1 USER-COMMAND cli1.
           SELECTION-SCREEN  PUSHBUTTON 60(10) btn2 USER-COMMAND cli2.
           SELECTION-SCREEN  PUSHBUTTON 75(10) btn3 USER-COMMAND cli3.


SELECTION-SCREEN END OF BLOCK b1.

*INITIALIZATION.
*
*  btn0 = 'SELECT'.
*  btn1 = 'INSERT'.
*  btn2 = 'UPDATE'.
*  btn3 = 'DELETE'.
