// Intelligent repair, Repair the vehicle by pressing the R key, without currently opening other locations such as the chat, terminal and scoreboard, avoiding accidental activation of the script.
// Physical details such as: broken glass, removed door, wrinkles will not be corrected, thus preventing others from noticing.

SCRIPT_START
{
LVAR_INT scplayer pcar

GET_PLAYER_CHAR 0 scplayer

main_loop:
WAIT 0

IF NOT IS_CHAT_OPENED 
AND NOT IS_CONSOLE_ACTIVE
AND NOT IS_SCOREBOARD_ACTIVE
    IF IS_CHAR_SITTING_IN_ANY_CAR scplayer
        GET_CAR_CHAR_IS_USING scplayer pcar
        IF IS_KEY_PRESSED VK_KEY_R
            SET_CAR_HEALTH pcar 1000
        ENDIF
    ENDIF
ENDIF

GOTO main_loop
}
SCRIPT_END