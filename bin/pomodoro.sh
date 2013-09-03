#!/bin/sh

# start interrupt interrupt-over reset resume end break-end interval
POM_SPECIALS="Edit... Interrupted Reset End"
HEIGHT=25
INTERVAL=25

_pom_list () {
    # this could be better.  Options: simplenote or private gist
    cat $HOME/.pomodoro_list
}

_pom_time_left () {
    interval_sec=$(($INTERVAL * 60))
    start=$(date -r ~/.pomodoro_current +%s)
    end=$(($start + $interval_sec + 60))
    now=$(date +%s)
    left=$(($end - $now))

    date -d "@$left" +'%M:%S'
}

_pom_status () {
    echo $(_pom_time_left) left
}

_pom_menu () { 
    (echo $POM_SPECIALS | tr ' ' '\n' ; _pom_list) | dmenu -i -p "$(_pom_time_left)" -l "$HEIGHT" 
}

_pom_put () {
    echo -n "$*" > ~/.pomodoro_current
    touch ~/.pomodoro_current
}

_pom_current () {
    cat ~/.pomodoro_current
}

case "$1" in
    time-left)
        _pom_time_left
    ;;
    current)
        _pom_current
    ;;
    *)
        POM=$(_pom_menu)

        case "$POM" in
            Edit...)
                urxvt -e vim $HOME/.pomodoro_list &>/dev/null
            ;;

            Interrupt)
                _pom_stop
                _pom_interrupt
            ;;

            Reset)
                _pom_stop
                _pom_menu
            ;;

            End)
                _pom_stop
                _pom_end
            ;;

            # Exited without selecting an option
            '')
            ;;

            # Selected a pomodoro
            *)
                _pom_put "$POM"
            ;;
        esac
    ;;
esac
