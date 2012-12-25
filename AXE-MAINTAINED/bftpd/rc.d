#!/bin/bash

source /etc/rc.conf
source /etc/rc.d/functions

# only root should execute this script
if ! $(chk_root) ;then
    msg_fail "You are not root"
    exit 1
fi

# print usage and exit
usage() {
    printf "
usage: rc.d start|restart|stop|<other> [-a|-n|-A] [-s|-S] [<daemon>]

actions:
  start             Start daemon(s)
  restart           Restart daemon(s)
  stop              Stop daemon(s)
  <other>           Custom daemon(s) action

options:
  -a|--auto         Execute action on daemons defined in /etc/rc.conf
  -n|--noauto       Execute action on daemons not defined in /etc/rc.conf
  -A|--all          Execute action on all daemons
  -s|--started      Execute action on all started daemons
  -S|--stopped      Execute action on all stopped daemons

positional:
  <daemon>          Space separated list of script(s) in /etc/rc.d
    

WARNING: The above actions are recommended by the LSB-policy but
         deamon scripts are free to implement them or not along
         with custom action(s) where needed. 
"
	exit 1
}

# strips matches in $1 from $2 and returns the result
filter() {
    local rtrn="${1}"

    for e in ${2};do
        rtrn="${rtrn/$e/}"
    done
    
    echo "${rtrn}"
}

# arguments handler
if [ "$#" -gt "1" ];then
    action="${1}"
    all_daemons="$(find /etc/rc.d -maxdepth 1 -type f -executable -printf '%f ')"
    auto_daemons="${DAEMONS[@]}"
    started_daemons="$(find /run/daemons -type f -printf '%f ')"
    noauto_daemons=$(filter "${all_daemons}" "${auto_daemons}")
    stopped_daemons=$(filter "${all_daemons}" "${started_daemons}")
    daemons=""
    
    # asign daemon(s) to which action should be applied
    for arg in ${@:2};do
        case "${arg}" in
            -a|--auto) daemons="${auto_daemons}" ;;
            -n|--noauto) daemons="${noauto_daemons}" ;;
            -A|--all) daemons="${all_daemons}" ;;
            -s|--started) daemons=$(filter "${daemons}" "${stopped_daemons}") ;;
            -S|--stopped) daemons=$(filter "${daemons}" "${started_daemons}") ;;
            -*|--*) msg_fail "Invalid argument: ${C_RED}${arg}${C_CLEAR}" ;;
            *) daemons="${daemons} ${arg}" ;;
        esac    
    done
    
    # for each daemon
    for daemon in ${daemons};do
        # do some checks
        if ! dmn_valid ${daemon};then
            msg_fail "Daemon ${C_RED}${daemon}${C_WHITE} does not exist or is not executable.${C_CLEAR}"
        elif [ "${action}" = "start" ] && dmn_running ${daemon};then
            msg_fail "Deamon ${C_RED}${daemon}${C_WHITE} is already running. Try '${C_RED}rc.d restart ${daemon}${C_WHITE}'.${C_CLEAR}"
         elif [ "${action}" = "restart" ] || [ "${action}" = "stop" ] && ! dmn_running ${daemon};then
            msg_fail "Deamon ${C_RED}${daemon}${C_WHITE} is not running.${C_CLEAR}"
        else
            "/etc/rc.d/${daemon}" "${action}"
        fi
    done
else
    usage
fi
