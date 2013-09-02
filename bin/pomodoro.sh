#!/bin/sh

POMTXT="/Users/sam.powers/Library/Application\ Support/Notational\ Data/pomodoros.txt"

function pomlist {
	#st "$POMTXT"
	open "nvalt://pomodoros"
}

pomlist
exit 0

RETVAL=0
case "$1" in
	start)

	;;

	interrupt)

	;;

	interrupt-over)

	;;

	reset)
	;;

	resume)
	;;

	end)
	;;

	break-end)
	;;

	interval)
	;;

	*)
	;;
esac

exit $RETVAL
