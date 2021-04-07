ARG DISTRO=alpine:3
FROM $DISTRO


RUN \
  apk -U upgrade && \
  apk add -U --no-cache tzdata rsyslog logrotate && \
  rm -f /etc/logrotate.d/* && \
  rm -rf /var/cache/apk/*

COPY root/ /

VOLUME ["/state"]

EXPOSE 514/udp
EXPOSE 514/tcp

CMD ["/run.sh"]

HEALTHCHECK --start-period=1s --interval=30s --timeout=5s CMD /healthcheck.sh

