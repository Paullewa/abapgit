interface ZINTERFACE_TRAVEL
  public .

    TYPES: BEGIN OF ty_sb,
         mandt TYPE spfli-mandt,
         carrid type spfli-carrid,
         connid type spfli-connid,
         FLDATE type sbook-FLDATE,
         PASSFORM type sbook-PASSFORM,
         PASSNAME type sbook-passname,
         PASSBIRTH type sbook-PASSBIRTH,
         CLASS type sbook-CLASS,
         COUNTRYFR type spfli-COUNTRYFR,
         CITYFROM type spfli-CITYFROM,
         CITYTO type spfli-CITYTO,
         AGENCYNUM type sbook-AGENCYNUM,
         INVOICE type sbook-INVOICE,
         DEPTIME TYPE spfli-DEPTIME,
         ARRTIME type spfli-ARRTIME,
         DISTANCE type spfli-DISTANCE,
   END OF ty_sb.
   DATA:
       wa_sb TYPE ty_sb,      " work area
       it_sb TYPE TABLE OF ty_sb. "  intern table
  METHODS: select_all_entries IMPORTING  ip_connid TYPE  spfli-connid RETURNING VALUE(rt_flight) TYPE ty_sb.
*           select_single_entries,
*           sort_entries_,
*           insert_entries,
*           delete_entries,
*           update_entries.

endinterface.
