
FROM alpine AS output

WORKDIR /app

RUN apk add npm && npm install meshcentral

ENTRYPOINT ["/usr/bin/node", "node_modules/meshcentral"]
CMD ["--wanonly"]
