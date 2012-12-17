unset LANG

if [ -s /etc/rc.conf ]; then
	source /etc/rc.conf
fi

localevars=("${LC_CTYPE}" "${LC_COLLATE}" "${LC_TIME}" "${LC_NUMERIC}"
            "${LC_MONETARY}" "${LC_MESSAGES}" "${LC_ALL}")
            
export LANG="${LANG:-C}"     
for var in localevars;do
    if [ -n "${var}" ]; then
        export ${var}
    else
        unset ${var}
    fi
done
unset localevars