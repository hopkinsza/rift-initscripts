#!/bin/mksh
# vim: syntax=sh

# todo: don't fsck a network /

msg 'fsck rootfs'

msg2 'mounting / read-only'
mount -o remount,ro /

msg2 'fsck:'
fsck -p /

msg2 'mounting / read-write'
mount -o remount,rw /
