
FROM alpine AS builder

ARG NGINX_VERSION="stable-1.28"
ARG NGINX_CONFIGURE="--with-http_dav_module"

RUN apk add build-base git pcre-dev zlib-dev
RUN git clone https://github.com/nginx/nginx.git /nginx
RUN cd /nginx && git checkout ${NGINX_VERSION}
RUN cd /nginx && ./auto/configure ${NGINX_CONFIGURE} && make
RUN mkdir /empty

FROM scratch AS output
COPY --from=builder /lib/ld-musl-* /lib/libc.musl-* /lib/
COPY --from=builder /usr/lib/libpcre.so.1 /usr/lib/libz.so.1 /lib/
COPY --from=builder /etc/passwd /etc/passwd
COPY --from=builder /empty /usr/local/nginx/logs
COPY --from=builder /nginx/objs/nginx /nginx
COPY nginx.conf /config/nginx.conf

CMD ["/nginx", "-c", "/config/nginx.conf"]

# HTTP
EXPOSE 80/tcp
