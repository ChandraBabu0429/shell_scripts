#!/bin/bash

DISK_USAGE=$(/usr/bin/df -H | /usr/bin/grep -vE '^Filesystem|tmpfs|cdrom' | /usr/bin/awk '{ print $5 }')

echo "This is a Disk usage mail $DISK_USAGE" | /usr/bin/mail -s "message" seenathur.chandrababu@gmail.com
