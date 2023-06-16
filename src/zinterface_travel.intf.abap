interface ZINTERFACE_TRAVEL
  public .


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

  data WA_SB type TY_SB .
  data:
    it_sb TYPE  TABLE OF ty_sb .     "  intern table before creating a standard table ( joining two Tables)
  data:                                        " work area
    it_zbook_spfli TYPE TABLE OF zbook_spfli .    " interne table after creating DB ZBOOK_SPFLI, no use of join

**************************************************************
  methods SELECT_ALL_ENTRIES
    importing
      !IP_CONNID type SPFLI-CONNID
    returning
      value(RT_FLIGHT) type TY_SB .
**************************************************************
  methods SELECT_SINGLE_ENTRIES
    importing
      !I_CONNID type SPFLI-CONNID
      !I_PASSNAME type SBOOK-PASSNAME
    returning
      value(RT_FLIGHT) type TY_SB .
***************************************************************
  methods SORT_ENTRIES
    importing
      !IP_CONNID type SPFLI-CONNID
    returning
      value(RT_FLIGHT) type TY_SB .
*+++++++++++++++++***************************************
  methods INSERT_ENTRIES
    importing
      !IP_MANDT type SPFLI-MANDT optional
      value(IP_CARRID) type SPFLI-CARRID optional
      !IP_CONNID type SPFLI-CONNID optional
      !IP_FLDATE type DATS optional
      !IP_PASSNAME type SBOOK-PASSNAME optional
      !IP_COUNTRYFR type SPFLI-COUNTRYFR optional
      !IP_CITYFROM type SPFLI-CITYFROM optional
      !IP_CITYTO type SPFLI-CITYTO optional
      !IP_AGENCYNUM type SBOOK-AGENCYNUM optional
      !IP_DEPTIME type SPFLI-DEPTIME optional
      !IP_ARRTIME type SPFLI-ARRTIME optional
      !IP_DISTANCE type SPFLI-DISTANCE
    returning
      value(RT_FLIGHT) type TY_SB .
endinterface.
