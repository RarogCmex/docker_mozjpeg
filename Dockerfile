# https://github.com/mozilla/mozjpeg/releases
FROM alpine:latest AS builder
ENV VERSION 3.3.1

WORKDIR /src/mozjpeg
ADD https://github.com/mozilla/mozjpeg/archive/v${VERSION}.tar.gz ./

RUN apk add --no-cache build-base autoconf automake libtool pkgconf nasm tar \
 && tar -xzf v${VERSION}.tar.gz \
 && mv mozjpeg-${VERSION} src \
 && cd src \
 && autoreconf -fiv \
 && cd .. \
 && mkdir build \
 && cd build \
 && ../src/configure \
 && make install prefix=/usr/local libdir=/usr/local/lib64

# copy to target image
FROM alpine:latest
RUN apk add --no-cache bash
COPY --from=builder /usr/local /usr/local
ENTRYPOINT /bin/bash
