#!/bin/mksh
# vim: syntax=sh

# this file is for getting the kernel configured / initialized:
# - load specifically configured modules
# - udev will load more as needed
# - set sysctl variables

#
# kmods
#

msg 'loading kernel modules'

# /etc/modules
stripcom /etc/modules.conf | while read i; do
	modprobe -b $i
done

# modules that must be loaded before starting udev
for i in $(kmod static-nodes 2>/dev/null | awk '/Module/ {print $2}'); do
	modprobe -bq $i 2>/dev/null
done

#
# udev
#

msg 'starting udev and waiting for devices to settle'

udevd=

if command -v udevd >/dev/null; then
	udevd=udevd
elif [[ -x /lib/systemd/systemd-udevd ]]; then
	udevd=/lib/systemd/systemd-udevd
else
	warn 'cannot find udevd'
fi

if [[ -n $udevd ]]; then
	$udevd --daemon
	udevadm trigger --action=add --type=subsystems
	udevadm trigger --action=add --type=devices
	udevadm settle
fi

unset udevd

#
# sysctl
#

msg 'setting sysctl variables:'
sysctl -f /etc/sysctl.conf
