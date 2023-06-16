"Name: \PR:ZRTRAVEL_FLIGHT\EX:ZBADI_SBPFL\EI
ENHANCEMENT 0 ZBADI_SBPFL_IMP2.
*
  data l_handler TYPE REF TO ZBADI_SBPFL.
  Get BADI l_handler.
  call badi l_handler->send_response.
ENDENHANCEMENT.
