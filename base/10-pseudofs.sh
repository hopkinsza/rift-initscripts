#!/bin/mksh
# vim: syntax=sh

# mount pseudo-filesystems;
# must be present in /etc/fstab

msg 'mounting pseudo-filesystems'

if [[ -n $pseudofs ]]; then
	for i in $pseudofs; do
		mkdir -p $i
		mountpoint -q $i || mount $i
	done
fi

# populate /run
mkdir -p -m0755 /run/lvm /run/lock /run/log
