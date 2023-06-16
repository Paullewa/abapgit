*&---------------------------------------------------------------------*
*& Include ZINCL_RTRAVEL
*&---------------------------------------------------------------------*

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
