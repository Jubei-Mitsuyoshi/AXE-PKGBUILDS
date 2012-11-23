#!/bin/bash

. /etc/rc.conf
. /etc/rc.d/functions

name=crond
. /etc/conf.d/crond
PID=$(pidof -o %PPID /usr/sbin/crond)

case "$1" in
start)
	msg_busy "Starting $name daemon"
	[[ -z "$PID" ]] && /usr/sbin/crond $CRONDARGS &>/dev/null \
	&& { dmn_add $name; msg_ok; } \
	|| { msg_fail; exit 1; }
	;;
stop)
	msg_busy "Stopping $name daemon"
	[[ -n "$PID" ]] && kill $PID &>/dev/null \
	&& { dmn_rm $name; msg_ok; } \
	|| { msg_fail; exit 1; }
	;;
reload)
	msg_busy "Reloading $name daemon"
	[[ -n "$PID" ]] && kill -HUP $PID &>/dev/null \
	&& { msg_ok; } \
	|| { msg_fail; exit 1; }
	;;
restart)
	$0 stop
	sleep 1
	$0 start
	;;
*)
	echo "usage: $0 {start|stop|restart|reload}"
	;;
esac
exit 0
