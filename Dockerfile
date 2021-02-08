ARG DISTRO=alpine:3
FROM $DISTRO


RUN \
  apk add --no-cache tzdata rsyslog logrotate && \
  rm -f /etc/logrotate.d/*

COPY root/ /

EXPOSE 514/udp
EXPOSE 514/tcp

CMD ["/run.sh"]

HEALTHCHECK --start-period=30s --interval=30s --timeout=30s CMD /healthcheck.sh

