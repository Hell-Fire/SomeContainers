FROM alpine AS builder
RUN apk add ser2net

FROM scratch AS output
COPY --from=builder /lib/ld-musl-* /lib/libc.musl-* /lib/
COPY --from=builder /usr/sbin/ser2net /usr/sbin/ser2net
COPY --from=builder /etc/ser2net.conf /etc/ser2net.conf

ENTRYPOINT ["/usr/sbin/ser2net"]
CMD ["-n", "-c", "/etc/ser2net.conf"]
