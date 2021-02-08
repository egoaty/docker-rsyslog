# egoaty/rsyslog
Remote rsyslog server with logrotate support

## Environment Variables:

* ```PUID``` ... UID rsyslog should run under after startup. Your log directories/files must be writeable by this user.
* ```PGID``` ... GID rsyslog should run under after startup.
* ```TZ ```  ... Timezone for container.

## rsyslog configuration

By default logging to port 514 (UDP and TCP) is enabled.

Mount your configuration directory to ```/etc/rsyslogd.conf```. Any files named ```*.conf``` will be included in the rsyslog configuration

For your log file targets you can mount a volume/bind-mount to any location in the container and configure rsyslogd to write to this location.

Messages from the rsyslogd process and cron are logged to ```stdout``` only by default. 

## Logrotate

logrotate is available in the container. Mount your configuration directory to ```/etc/logrotate.d```. Logrotate runs daily.

Add the following postrotate to your configurations:

```
    postrotate
        kill -HUP $(cat /var/run/rsyslogd.pid)
    endscript
```

## Running the container

Docker compose example:

```
version: "2"

services:
  rsyslogd:
    image: 'egoaty/rsyslog'
    ports:
      - '514:514/udp'
      - '514:514/tcp'
    volumes:
      - ./rsyslogd/conf.d:/etc/rsyslog.d:ro
      - ./rsyslogd/logrotate.d:/etc/logrotate.d:ro
      - /path/to/log:/log:rw
    environment:
      - PUID=1000
      - PGID=1000
      - TZ=Europe/Vienna
    restart: unless-stopped
```

