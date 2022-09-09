#!/bin/mksh
# vim: syntax=sh

# time setup requires /usr/share/zoneinfo

# set the system timezone
if [[ -n $timezone ]]; then
	msg "setting system timezone to $timezone"
	if [[ "$(readlink /etc/localtime)" != $timezone ]]; then
		ln -sf "/usr/share/zoneinfo/$timezone" /etc/localtime
	fi
fi

# let the kernel know if hardware clock is in utc or local time;
# also sets the kernel's timezone for jankiness like fat timestamps
if [[ -n $hwclocktz ]]; then
	msg "interpreting hardware clock as $hwclocktz"
	hwclock --systz "--$hwclocktz"
fi
