FROM alpine AS builder

RUN apk add dhcp-server-vanilla

FROM scratch AS output

COPY --from=builder /lib/ld-musl-* /lib/libc.musl-* /usr/lib/libgcc_s.so.1 /lib/
COPY --from=builder /usr/sbin/dhcpd /usr/sbin/dhcpd

CMD ["/usr/sbin/dhcpd"]

# bootps/dhcp-server
EXPOSE 67/udp
