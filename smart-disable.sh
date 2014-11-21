#!/bin/bash
#
# smart-disable.sh
#
# Disable SMART on all disks.
#
# Copyright (C) 2014  Nexenta Systems
# William Kettler <william.kettler@nexenta.com>
#

echo "Disabling SMART collector..."
nmc -c 'setup collector smart-collector disable'

echo "Discovering devices..."

# Disover disks
disks=$(nmc -c 'show lun slotmap' | grep c*t*d0 | cut -d" " -f1)

echo "Disabling SMART..."
(
for d in $disks; do
    echo ""
    echo "setup lun smart disable -d $d"
    echo ""
done
) | nmc

# This should return if above succeeded o/w we must disable manually
nmc -c 'show lun smartstat' | less
