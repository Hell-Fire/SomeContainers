FROM alpine AS output

RUN apk add keepalived curl

ENTRYPOINT ["/usr/sbin/keepalived","--dont-fork","--log-console"]
