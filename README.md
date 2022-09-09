rift-initscripts
================

The initscripts for rift linux,
run once at system boot.

There are 3 stages.

base
----

Things to be done with only /etc, /bin, /sbin, and /lib mounted.

Then, mount critical local filesystems --
everything that is not a network filesystem.
`/var` is typically included here because `dhcpcd` will need it to
bring up the network.
Additionally, the random seed is stored in `/var/db/random-seed` by default.

localmounted
------------

Things to be done now that local filesystems have been mounted.
This is just loading the random seed and bringing up the network
with `/etc/netstart`.

`/etc/netstart` can be a no-op if you don't have any critical filesystems
mounted over the network;
you can set it up later, such as in `/etc/rc.local`.

remotemounted
-------------

Things to be done now that all critical filesystems have been mounted.
