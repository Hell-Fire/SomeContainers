FROM alpine AS builder
RUN apk add git go make patch
RUN git clone https://github.com/zorchenhimer/MovieNight.git && cd MovieNight && git checkout adf00fb
COPY autoplay-no-mute.patch stats.patch autorestart.patch /
RUN cd MovieNight && patch -u -p1 -i /autoplay-no-mute.patch
RUN cd MovieNight && patch -u -p1 -i /stats.patch
RUN cd MovieNight && patch -u -p1 -i /autorestart.patch
ARG TARGETOS
ARG TARGETARCH
RUN make -C MovieNight TARGET=$TARGETOS ARCH=$TARGETARCH

FROM scratch AS output
COPY --from=builder /lib/ld-musl-* /lib/libc.musl-* /lib/
COPY --from=builder MovieNight/MovieNight /MovieNight
COPY --from=builder MovieNight/settings.json /settings.json

CMD ["/MovieNight"]

# RTMP
EXPOSE 1935/tcp
# HTTP
EXPOSE 8089/tcp
