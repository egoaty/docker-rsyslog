ARG DISTRO=alpine:3
FROM $DISTRO


RUN \
  apk add --no-cache tzdata rsyslog

COPY root/ /

EXPOSE 514/udp
EXPOSE 514/tcp

CMD ["/run.sh"]

