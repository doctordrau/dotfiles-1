#!/bin/sh

# start interrupt interrupt-over reset resume end break-end interval
HEIGHT=25
POM_SPECIALS="Edit... Interrupted Reset End"
POM_LIST="$HOME/.pomodoro_list"
POM_CURRENT="$HOME/.pomodoro_current"
POM_LOG="$HOME/.pomodoro_log"

_pom_list () {
    # this could be better.  Options: simplenote or private gist
    cat $POM_LIST
}

_pom_time_left () {
    if [ -f "$POM_CURRENT" ]; then
        INTERVAL=$((25 * 60)) # 25 minutes
        #INTERVAL=5 # testing
        POM_START=$(date -r $POM_CURRENT +%s)
        END=$(($POM_START + $INTERVAL + 60)) # grace period
        #END=$(($POM_START + $INTERVAL)) # testing
        NOW=$(date +%s)
        LEFT=$(($END - $NOW))

        if [ "$1" == "sec" ]; then
            echo $LEFT
        else
            date -d "@$LEFT" +'%M:%S'
        fi
    fi
}

_pom_menu () {
    (echo $POM_SPECIALS | tr ' ' '\n' ; echo ; _pom_list) | dmenu -i -l "$HEIGHT" 
}

_pom_put () {
    echo -n "$*" > $POM_CURRENT
}

_pom_get () {
    if [ -f $POM_CURRENT ]; then
        cat $POM_CURRENT
    fi
}

_pom_clean () {
    rm -f $POM_CURRENT &>/dev/null
}

_pom_reset () {
    touch $POM_CURRENT
}

_pom_log () {
    x="$1" ; shift
    echo "$(date +%T)" "$x" "$*" >> $POM_LOG
    notify-send "pomodoro $x" "$*"
}


ACTION="$1"
shift

case "$ACTION" in
    time)
        if [ "$(_pom_time_left sec)" -le 0 ]; then
            $0 end
        else
            _pom_time_left
        fi
    ;;

    current)
        _pom_get
    ;;

    start)
        _pom_log start "$*"
        _pom_put "$*"
    ;;
 
    end)
        p="$(_pom_get)"
        if [ -n "$p" ]; then
            _pom_log end "$p"
            _pom_clean
        fi
    ;;

    interrupted)
        p="$(_pom_get)"
        if [ -n "$p" ]; then
            _pom_log interrupt "$p"
            _pom_clean
        fi
    ;;

    reset)
        p="$(_pom_get)"
        if [ -n "$p" ]; then
            _pom_log reset "$p"
            _pom_reset
        fi
    ;;
   
    *)
        SELECTION=$(_pom_menu)

        case "$SELECTION" in
            Edit...)
               mousepad "$POM_LIST" &>/dev/null
            ;;

            Interrupted*)
                $0 interrupted "$reason"
            ;;

            Reset)
                $0 reset
            ;;

            End)
                $0 end
            ;;

            # Exited without selecting an option
            '')
            ;;

            # Selected a pomodoro
            *)
                $0 start "$SELECTION"
            ;;
        esac
    ;;
esac
