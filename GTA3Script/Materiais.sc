SCRIPT_START
{
LVAR_INT scplayer

GET_PLAYER_CHAR 0 scplayer

main_loop:
WAIT 0

IF IS_CHAR_IN_AREA_2D scplayer 1419.0 -1322.0 1428.0 -1320.0 1
OR IS_CHAR_IN_AREA_2D scplayer 2815.0 -1423.0 2828.0 -1424.0 1 
OR IS_CHAR_IN_AREA_2D scplayer -1741.0 1248.0 -1738.0 1258.0 1
    WAIT 300
    SET_CHAT_TEXT "/comprar materiales"
    WAIT 5000
ENDIF

GOTO main_loop
}
SCRIPT_END