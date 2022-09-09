#!/bin/mksh
# vim: syntax=sh

# mount remote filesystems,
# possibly including /usr and other essentials.

msg 'mounting remote filesystems'
for i in $crit_fs_remote; do
	mountpoint -q "$i" || mount "$i"
done
