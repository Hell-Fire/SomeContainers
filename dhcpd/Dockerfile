FROM alpine AS builder

RUN apk add dhcp-server-vanilla
COPY dhcpd.sh /dhcpd.sh
RUN chmod +x /dhcpd.sh

FROM scratch AS output

# libs
COPY --from=builder /lib/ld-musl-* /lib/libc.musl-* /usr/lib/libgcc_s.so.1 /lib/

# dhcpd.sh deps
COPY --from=builder /bin/busybox /bin/busybox
SHELL ["/bin/busybox"]
RUN ln -s /bin/busybox /bin/mkdir
RUN ln -s /bin/busybox /bin/cp
RUN ln -s /bin/busybox /sbin/ip
RUN ln -s /bin/busybox /usr/bin/awk
RUN ln -s /bin/busybox /bin/touch

# dhcpd proper
COPY --from=builder /usr/sbin/dhcpd /usr/sbin/dhcpd

# dhcpd.sh init
COPY --from=builder /dhcpd.sh /dhcpd.sh

ENTRYPOINT ["/dhcpd.sh"]
CMD ["-d"]

# bootps/dhcp-server
EXPOSE 67/udp
