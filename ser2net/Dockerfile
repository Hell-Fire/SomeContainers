FROM --platform=$BUILDPLATFORM alpine AS builder
RUN apk add ser2net

FROM --platform=$BUILDPLATFORM scratch AS output
COPY --from=builder /lib/ld-musl-x86_64.so.1 /lib/ld-musl-x86_64.so.1
COPY --from=builder /usr/sbin/ser2net /usr/sbin/ser2net
COPY --from=builder /etc/ser2net.conf /etc/ser2net.conf

CMD ["/usr/sbin/ser2net", "-c", "/etc/ser2net.conf"]
