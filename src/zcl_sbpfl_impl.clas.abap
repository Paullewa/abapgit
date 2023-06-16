class ZCL_SBPFL_IMPL definition
  public
  final
  create public .

public section.

  interfaces IF_BADI_INTERFACE .
  interfaces ZIF_EX_BADI_SPFLI .
protected section.
private section.
ENDCLASS.



CLASS ZCL_SBPFL_IMPL IMPLEMENTATION.


  method ZIF_EX_BADI_SPFLI~CONFIRMATION_DETAILS.
    DATA: it_zbsp type TABLE OF ZBOOK_SPFLi .
    SELECT *
    INTO TABLE it_zbsp
    FROM ZBOOK_SPFLI
    WHERE PASSNAME EQ I_NAME .
    if sy-subrc <> 0.
    clear it_zbsp.
   ENDIF.


  endmethod.


  method ZIF_EX_BADI_SPFLI~SEND_RESPONSE.
    MESSAGE ' OPERATION WAS SUCCESSFUL EXECUTED ' TYPE 'I'.
  endmethod.
ENDCLASS.
