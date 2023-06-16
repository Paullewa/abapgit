class ZCL_ZGW_F_BOOKING_DPC_EXT definition
  public
  inheriting from ZCL_ZGW_F_BOOKING_DPC
  create public .

public section.
protected section.

  methods ZBOOK_SPFLISET_DELETE_ENTITY
    redefinition .
  methods ZBOOK_SPFLISET_GET_ENTITY
    redefinition .
  methods ZBOOK_SPFLISET_GET_ENTITYSET
    redefinition .
private section.
ENDCLASS.



CLASS ZCL_ZGW_F_BOOKING_DPC_EXT IMPLEMENTATION.


  method ZBOOK_SPFLISET_DELETE_ENTITY.
**TRY.
*CALL METHOD SUPER->ZBOOK_SPFLISET_DELETE_ENTITY
*  EXPORTING
*    IV_ENTITY_NAME          =
*    IV_ENTITY_SET_NAME      =
*    IV_SOURCE_NAME          =
*    IT_KEY_TAB              =
**    io_tech_request_context =
*    IT_NAVIGATION_PATH      =
*    .
** CATCH /iwbep/cx_mgw_busi_exception .
** CATCH /iwbep/cx_mgw_tech_exception .
**ENDTRY.
     DATA(lv_connid) = it_key_tab[ name = ' connid ' ]-value.
     DATA(lv_fldate) = it_key_tab[ name = ' fldate ' ]-value.
     DATA(lv_passname) = it_key_tab[ name = ' passname ' ]-value.
    delete  from ZBOOK_SPFLI
         where connid = lv_connid
         AND   fldate = lv_fldate
         and   passname = lv_passname.

  endmethod.


  method ZBOOK_SPFLISET_GET_ENTITY.
**TRY.
*CALL METHOD SUPER->ZBOOK_SPFLISET_GET_ENTITY
*  EXPORTING
*    IV_ENTITY_NAME          =
*    IV_ENTITY_SET_NAME      =
*    IV_SOURCE_NAME          =
*    IT_KEY_TAB              =
**    io_request_object       =
**    io_tech_request_context =
*    IT_NAVIGATION_PATH      =
**  IMPORTING
**    er_entity               =
**    es_response_context     =
*    .
** CATCH /iwbep/cx_mgw_busi_exception .
** CATCH /iwbep/cx_mgw_tech_exception .
**ENDTRY.
  DATA(lv_connid) = it_key_tab[ name = ' connid ' ]-value.
    select SINGLE *
      from ZBOOK_SPFLI
      into er_entity
   where connid = lv_connid.

  endmethod.


  method ZBOOK_SPFLISET_GET_ENTITYSET.
**TRY.
*CALL METHOD SUPER->ZBOOK_SPFLISET_GET_ENTITYSET
*  EXPORTING
*    IV_ENTITY_NAME           =
*    IV_ENTITY_SET_NAME       =
*    IV_SOURCE_NAME           =
*    IT_FILTER_SELECT_OPTIONS =
*    IS_PAGING                =
*    IT_KEY_TAB               =
*    IT_NAVIGATION_PATH       =
*    IT_ORDER                 =
*    IV_FILTER_STRING         =
*    IV_SEARCH_STRING         =
**    io_tech_request_context  =
**  IMPORTING
**    et_entityset             =
**    es_response_context      =
*    .
** CATCH /iwbep/cx_mgw_busi_exception .
** CATCH /iwbep/cx_mgw_tech_exception .
**ENDTRY.
*   DATA(lv_connid) = it_key_tab[ name = ' connid ' ]-value.
    select *
      from ZBOOK_SPFLI
      into TABLE et_entityset.
*   where connid = lv_connid.

  endmethod.
ENDCLASS.
