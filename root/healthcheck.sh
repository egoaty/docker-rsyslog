#!/bin/sh

# Test for crond process
if ! kill -0 $( cat /var/run/crond.pid ) >/dev/null 2>&1; then
	echo "Cron not running"
	exit 1
fi

echo "OK"

