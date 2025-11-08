FROM alpine AS builder
RUN apk add icecast

FROM scratch AS output
COPY --from=builder /lib/ld-musl-* /lib/libc.musl-* /lib/libcrypto.so.* /lib/libssl.so.* /lib/libz.so.* /usr/lib/libbrotlicommon.so.* /usr/lib/libbrotlidec.so.* /usr/lib/libcurl.so.* /usr/lib/libidn2.so.* /usr/lib/liblzma.so.* /usr/lib/libnghttp2.so.* /usr/lib/libogg.so.* /usr/lib/libtheora.so.* /usr/lib/libunistring.so.* /usr/lib/libvorbis.so.* /usr/lib/libxml2.so.* /usr/lib/libxslt.so.* /lib/
COPY --from=builder /usr/share/icecast /usr/share/icecast
COPY --from=builder /usr/bin/icecast /icecast
COPY icecast.xml /config/icecast.xml

USER 1000:1000
CMD ["/icecast", "-c", "/config/icecast.xml"]

# HTTP
EXPOSE 8000/tcp
