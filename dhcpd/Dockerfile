FROM alpine AS builder

RUN apk add dhcp-server-vanilla
COPY dhcpd.sh /dhcpd.sh
RUN chmod +x /dhcpd.sh

FROM scratch AS output

# libs
COPY --from=builder /lib/ld-musl-* /lib/libc.musl-* /usr/lib/libgcc_s.so.1 /lib/

# dhcpd.sh deps
COPY --from=builder /bin/busybox /bin/busybox
SHELL ["/bin/busybox","ash","-c"]
RUN LN="/bin/busybox ln -s /bin/busybox" && \
    $LN /bin/mkdir && \
    mkdir -p /sbin /usr/bin && \
    $LN /bin/cp && \
    $LN /sbin/ip && \
    $LN /usr/bin/awk && \
    $LN /bin/touch && \
    $LN /bin/ash

# dhcpd proper
COPY --from=builder /usr/sbin/dhcpd /usr/sbin/dhcpd

# dhcpd.sh init
COPY --from=builder /dhcpd.sh /dhcpd.sh

ENTRYPOINT ["/bin/ash", "/dhcpd.sh"]
CMD ["-d"]

# bootps/dhcp-server
EXPOSE 67/udp
