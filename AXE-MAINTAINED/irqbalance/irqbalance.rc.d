#!/bin/bash

# source application-specific settings
ONESHOT=0
[ -f /etc/conf.d/irqbalance ] && . /etc/conf.d/irqbalance

if [ "$ONESHOT" -ne 0 ]; then
	ONESHOT_CMD="--oneshot"
fi

. /etc/rc.conf
. /etc/rc.d/functions

PID=`pidof -o %PPID /usr/sbin/irqbalance`
case "$1" in
  start)
    msg_busy "Starting IRQ balancing"
    [ -z "$PID" ] && /usr/sbin/irqbalance $ONESHOT_CMD
    if [ $? -gt 0 ]; then
      msg_fail
    else
      if [ "$ONESHOT" -eq 0 ]; then
        dmn_add irqbalance
      fi
      msg_ok
    fi
    ;;
  stop)
    msg_busy "Stopping IRQ balancing"
    [ ! -z "$PID" ] && kill $PID &> /dev/null
    if [ $? -gt 0 ]; then
      msg_fail
    else
      dmn_rm irqbalance
      msg_ok
    fi
    ;;
  restart)
    $0 stop
    sleep 1
    $0 start
    ;;
  *)
    echo "usage: $0 {start|stop|restart}"  
esac
exit 0
