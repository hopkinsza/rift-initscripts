#!/bin/mksh
# vim: syntax=sh

# fsck and mount critical local filesystems,
# possibly including /var and other essentials.
#
# Any steps needed beforehand go in /etc/rc.discoverfs:
# - activating software RAID
# - lvm
# - zfs/btrfs

# todo:
# swap could be using a file mounted on a local or remote fs
msg 'activating swap'
swapon -a || warn 'swapon failed'

if [[ -e /etc/rc.discoverfs ]]; then
	. /etc/rc.discoverfs
fi

msg 'mounting local filesystems'

# everything not marked noauto in /etc/fstab;
# fsck will determine if it can parallelize
msg2 'fsck:'
fsck -RAT -p

msg2 'mount'
mount -a
#for i in $mount_crit_local; do
#	mountpoint -q "$i" || mount "$i"
#done
