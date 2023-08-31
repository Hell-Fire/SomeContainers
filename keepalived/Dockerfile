FROM alpine AS output

RUN apk add keepalived

ENTRYPOINT ["/usr/sbin/keepalived","--dont-fork","--log-console"]
