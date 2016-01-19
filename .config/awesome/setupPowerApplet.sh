#!/bin/sh

/bin/ps -ef | /bin/grep 'nm-applet' | /bin/grep -v 'grep' > /dev/null
res=$?
if [ ${res} -eq 1 ]; then
	/usr/bin/nm-applet &
fi
