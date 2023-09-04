FROM alpine AS builder
RUN apk add git
RUN git clone https://github.com/novnc/noVNC.git && cd noVNC && git checkout v1.4.0

FROM nginx AS output
COPY --from=builder noVNC /usr/share/nginx/html/
