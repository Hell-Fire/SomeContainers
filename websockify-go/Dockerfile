FROM alpine AS builder
RUN apk add git go
RUN git clone https://github.com/novnc/websockify-other.git && cd websockify-other && git checkout 05d6162
ARG TARGETOS
ARG TARGETARCH
RUN cd websockify-other/golang && CGO_ENABLED=0 GOOS=${TARGETOS} GOARCH=${TARGETARCH} go build

FROM scratch AS output
#COPY --from=builder /lib/ld-musl-* /lib/libc.musl-* /lib/
COPY --from=builder websockify-other/golang/websockify /websockify

ENTRYPOINT ["/websockify"]
CMD ["-l", "0.0.0.0:8080"]
