FROM alpine:latest

# https://github.com/mozilla/mozjpeg/releases
ENV VERSION 3.1

RUN apk add --no-cache bash build-base nasm

RUN cd /var/opt \
 && wget https://github.com/mozilla/mozjpeg/releases/download/v${VERSION}/mozjpeg-${VERSION}-release-source.tar.gz \
 && tar -xzf mozjpeg-${VERSION}-release-source.tar.gz \
 && rm mozjpeg-${VERSION}-release-source.tar.gz \
 && cd mozjpeg \
 && ./configure \
 && make \
 && ln -s /var/opt/mozjpeg/cjpeg /usr/bin/cjpeg \
 && ln -s /var/opt/mozjpeg/djpeg /usr/bin/djpeg

ENTRYPOINT /bin/bash
