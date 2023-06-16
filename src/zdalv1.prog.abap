*&---------------------------------------------------------------------*
*& Report ZDALV1
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zdalv1.
PARAMETERS p_connid TYPE sbook-connid.
DATA :ob_cont TYPE REF TO cl_gui_custom_container,
      ob_grid TYPE REF TO cl_gui_alv_grid,
      connid_cont TYPE REF TO cl_gui_custom_container,
      connid_grid TYPE REF TO cl_gui_alv_grid.

TYPES: BEGIN OF ty_sb,
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
   data: it_ty_sb TYPE STANDARD TABLE OF ty_sb,
         ls_ty_sb TYPE ty_sb,
         wa_ty_sb TYPE ty_sb.
  TYPES: BEGIN OF ty_tsb.
     INCLUDE TYPE ZSBOOK_SPFLI. "   STRUCTURE
  TYPES END OF ty_tsb.

  data it_ty_tsb TYPE  ty_tsb.

CLASS lcl_double_click DEFINITION.
  PUBLIC SECTION.
  METHODs double_click FOR EVENT double_click of cl_gui_alv_grid IMPORTING E_ROW E_COLUMN.
ENDCLASS.

CLASS lcl_double_click IMPLEMENTATION.
  METHOD double_click.
    CASE E_COLUMN-fieldname.
     when 'CONNID'.
*  Read internal table number using index
    READ TABLE it_ty_sb INTO wa_ty_sb INDEX E_ROW-INDEX
    TRANSPORTING connid.
  if sy-subrc = 0.
* retreieve sales document.
         PERFORM Getrowdate.
          if  it_ty_sb is NOT INITIAL.
* Display the Data in next Screen.
         call SCREEN 200.
       else.
         MESSAGE 'There is no connid for the interacted customer in' TYPE 'I'.
       ENDIF.
         ENDIF.
    MESSAGE 'Hello Paul' TYPE 'I'.


    when OTHERS.
         MESSAGE 'Hello Paul, Please Double Click on the Customer Id Column only' TYPE 'I'.
        ENDCASE.
  ENDMETHOD.
ENDCLASS.

data ob1 TYPE REF TO lcl_double_click.
START-OF-SELECTION.
 CALL SCREEN 100.

MODULE status_0100 OUTPUT.
  IF ob_cont IS NOT BOUND.
    SET PF-STATUS 'STATUS100'.
** STEP 3
* lINK CUSTOM CONTROL WITH CUSTOM CONTAINER
    CREATE OBJECT ob_cont
      EXPORTING
        container_name = 'CUSTCTRL1'.
* STEP 4  CREATE OBJECT FOR ALV GRID CLASS LINKING WITH CONTAINER OBJECT
CREATE OBJECT ob_grid
  EXPORTING
    i_parent          = ob_cont .

* retrieve data from database

  PERFORM GETENTRIES.
 IF it_ty_sb IS NOT INITIAL.
* Register the handler for double click.
   perform registerhandler.

* dISPLAY DATA
   PERFORM DISPLAYCONNID.
* SET TITLEBAR 'xxx'.
ENDIF.
ENDIF.
ENDMODULE.

MODULE user_command_0100 INPUT.
  CASE sy-ucomm.
    WHEN 'BACK'.
      LEAVE PROGRAM.
  ENDCASE.

ENDMODULE.
FORM GETENTRIES.
clear wa_ty_sb.
select SINGLE * from ZBOOK_SPFLI
         into wa_ty_sb
         where connid = p_connid.
  APPEND wa_ty_sb to it_ty_sb.
ENDFORM.
FORM displayconnid .
  CALL METHOD ob_grid->set_table_for_first_display
    EXPORTING
      I_STRUCTURE_NAME = 'ZSBOOK_SPFLI'
    CHANGING
      it_outtab                     = it_ty_sb.
ENDFORM.

*&---------------------------------------------------------------------*
FORM registerhandler .
CREATE OBJECT ob1.
set HANDLER ob1->double_click for ob_grid.

ENDFORM.

FORM getrowdate .
SELECT * FROM  ZBOOK_SPFLI
into TABLE it_ty_sb
WHERE connid = wa_ty_sb-connid.
ENDFORM.

MODULE status_0200 OUTPUT.
   IF  connid_cont IS NOT BOUND.
 SET PF-STATUS 'STATUS200'.
* SET TITLEBAR 'xxx'.
* Link custom control with custom container
 CREATE OBJECT connid_cont
   EXPORTING
   container_name              = 'CUSTCTRL2'.
* LINK custom container WITH GRID
 CREATE OBJECT connid_grid
   EXPORTING
     i_parent          = connid_cont .
* retrieve Data
 PERFORM displayconnid2.

 ENDIF.
ENDMODULE.
MODULE user_command_0200 INPUT.
case sy-ucomm.
  WHEN 'BACK'.
    LEAVE TO SCREEN 100.
  ENDCASE.
ENDMODULE.

FORM displayconnid2 .
CALL METHOD connid_grid->set_table_for_first_display
EXPORTING
    i_structure_name              = 'ZSBOOK_SPFLI'

  CHANGING
    it_outtab                     = it_ty_sb.

ENDFORM.
