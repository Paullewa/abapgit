interface ZIF_EX_BADI_SBPLI
  public .


  interfaces IF_BADI_INTERFACE .

  types TYI_SBF type ref to ZINTERFACE_TRAVEL .

  data MANDT type SPFLI-MANDT .
  data CARRID type SPFLI-CARRID .
  data CONNID type SPFLI-CONNID .
  data FLDATE type DATS .
  data PASSNAME type SBOOK-PASSNAME .
  data COUNTRYFR type SPFLI-COUNTRYFR .
  data CITYFROM type SPFLI-CITYFROM .
  data CITYTO type SPFLI-CITYTO .
  data AGENCYNUM type SBOOK-AGENCYNUM .
  data DEPTIME type SPFLI-DEPTIME .
  data ARRTIME type SPFLI-ARRTIME .
  data DISTANCE type SPFLI-DISTANCE .

  class-methods SELECT_ENTRIES
    importing
      !CARRID type SPFLI-CARRID .
endinterface.
