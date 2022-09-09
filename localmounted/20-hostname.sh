#!/bin/mksh
# vim: syntax=sh

msg 'setting hostname'
if [[ -n $hostname ]]; then
	hostname $hostname
elif [[ -r /etc/hostname ]]; then
	hostname "$(stripcom /etc/hostname)"
else
	warn 'no hostname set'
fi
