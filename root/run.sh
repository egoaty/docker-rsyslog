#!/bin/sh
##
## Run the daemon (lighttpd)
##
## Environment Variables:
##  PUID    ... unprivileged UID
##  PGID    ... unprivileged GID
##

user="rsyslog"
group="rsyslog"
if ! id ${user} >/dev/null 2>&1; then
        addgroup -g "${PGID:=100000}" "${group}"
        adduser -h / -H -D -G "${group}" -u "${PUID:=100000}" "${user}"
fi

# Start crond in background (for logrotate)
crond || exit 1

# cleanup
rm -f /var/run/rsyslogd.pid

# Run rsyslogd in foreground
runcmd="rsyslogd -n -i /var/run/rsyslogd.pid"
exec ${runcmd}

