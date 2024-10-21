FROM alpine AS builder
RUN apk add stunnel

FROM scratch AS output
COPY --from=builder /lib/ld-musl-* /lib/libc.musl-* /lib/
COPY --from=builder /usr/bin/stunnel /usr/bin/stunnel
COPY --from=builder /etc/stunnel/stunnel.conf /etc/stunnel/stunnel.conf

ENTRYPOINT ["/usr/bin/stunnel"]
CMD ["-help"]
