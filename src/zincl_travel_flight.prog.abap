**&---------------------------------------------------------------------*
**& Include ZINCL_TRAVEL_FLIGHT
**&---------------------------------------------------------------------*

*SELECTION-SCREEN BEGIN OF SCREEN 100 TITLE text-001.
SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE text-001.
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
SELECTION-SCREEN END OF BLOCK b1.
*SELECTION-SCREEN END OF SCREEN 100.
*
*SELECTION-SCREEN BEGIN OF SCREEN 100 TITLE title.
*
*SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE text-t01.
*PARAMETERs:rad1 RADIOBUTTON GROUP rad USER-COMMAND frad1 DEFAULT 'X',
*          rad2 RADIOBUTTON GROUP rad .
*SELECTION-SCREEN END OF BLOCK b1.
*SELECTION-SCREEN BEGIN OF BLOCK b2 WITH FRAME TITLE text-t02.
*
*PARAMETERS: p_mandt  TYPE spfli-mandt,
*            p_conid  TYPE  spfli-connid  OBLIGATORY,
*            p_carrid TYPE spfli-carrid,
*            p_fdate  TYPE sbook-fldate,
*            p_pname  TYPE sbook-passname,
*            p_ctryfr TYPE spfli-countryfr,
*            p_cfro   TYPE spfli-cityfrom,
*            p_cto    TYPE  spfli-cityto,
*            p_agnum  TYPE sbook-agencynum,
*            p_dtime  TYPE spfli-deptime,
*            p_atime  TYPE spfli-arrtime,
*            p_dist   TYPE spfli-distance.
*
*SELECTION-SCREEN END OF BLOCK b2.
*
*SELECTION-SCREEN END OF SCREEN 100.
*
*
*
**name = 'FETCH'.
*title = 'Test Report'.
*CALL SELECTION-SCREEN '100'.
*
*
*TYPE-POOLS slis.
*
*AT SELECTION-SCREEN OUTPUT.
*
*
*
*  IF rad1 = 'X'.
*    LOOP AT SCREEN.
*      IF screen-group1 = 'G1' OR screen-group1 = 'G4'.
*        screen-active = '1'.
*        screen-input = 0.
*      ELSEIF screen-group1 = 'G2'.
*        screen-active = '0'.
*      ENDIF.
*      MODIFY SCREEN.
*    ENDLOOP.
*
*  ELSEIF rad2 = 'X'.
*    LOOP AT SCREEN.
*      IF screen-group1 = 'G1'  OR screen-group1 = 'G4' OR screen-group1 = 'G3' OR screen-group1 = 'G5'.
*        screen-active = '0'.
*      ELSEIF screen-group1 = 'G2'.
*        screen-active = '1'.
*
*      ENDIF.
*      MODIFY SCREEN.
*    ENDLOOP.
*  ENDIF.
*
**  IF mtr = 'X'.
**    LOOP AT SCREEN.
**      IF screen-group1 = 'G1'.
**        screen-input = 1 .
**
**      ENDIF.
**      MODIFY SCREEN.
**    ENDLOOP.
**  ENDIF.
**
**  IF sloc = 'X'.
**    LOOP AT SCREEN.
**      IF screen-group1 = 'G4'.
**        screen-input = 1 .
**
**      ENDIF.
**      MODIFY SCREEN.
**    ENDLOOP.
**  ENDIF.
*
*clear sy-ucomm.
**  iflag = 1.
