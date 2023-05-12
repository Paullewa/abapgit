
CLASS zcl_travel_flight DEFINITION PUBLIC.

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




