interface ZINTERFACE_TRAVEL
  public .


  types:
    BEGIN OF ty_sb,
           mandt     TYPE spfli-mandt,
           carrid    TYPE spfli-carrid,
           connid    TYPE spfli-connid,
           fldate    TYPE dats,
           passname  TYPE sbook-passname,

           countryfr TYPE spfli-countryfr,
           cityfrom  TYPE spfli-cityfrom,
           cityto    TYPE spfli-cityto,
           agencynum TYPE sbook-agencynum,

           deptime   TYPE spfli-deptime,
           arrtime   TYPE spfli-arrtime,
           distance  TYPE spfli-distance,
         END OF ty_sb .

  data: WA_SB type TY_SB ,                     " work area
        it_sb TYPE TABLE OF ty_sb . "  intern table

**************************************************************
  methods SELECT_ALL_ENTRIES
    importing
      !IP_CONNID type SPFLI-CONNID
    returning
      value(RT_FLIGHT) type TY_SB .
**************************************************************
  methods SELECT_SINGLE_ENTRIES
    importing
      !IP_CONNID type SPFLI-CONNID
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
