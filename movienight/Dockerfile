FROM alpine AS builder
RUN apk add git go make patch
RUN git clone https://github.com/zorchenhimer/MovieNight.git && cd MovieNight && git checkout 75854ce
COPY /patches/ /patches/
RUN cd MovieNight \
        && for i in ../patches/*.patch; do \
            echo applying $i; \
            patch --no-backup-if-mismatch --forward --reject-file=/tmp/patch.rej --unified --strip=1 --in=$i; \
        done
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
