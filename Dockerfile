# syntax=docker/dockerfile:1
FROM alpine:3.14
WORKDIR /code
COPY . .
RUN apk update && \
    apk add --no-cache bash && \
    apk add ca-certificates && \
    update-ca-certificates && \
    apk add gcompat && \
    apk add git
RUN chmod +x scripts/setup.sh
ENTRYPOINT ["scripts/setup.sh"]