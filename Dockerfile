# https://github.com/mozilla/mozjpeg/releases
FROM ubuntu:latest AS builder
ENV VERSION 4.0.3

WORKDIR /src/mozjpeg
ADD https://github.com/mozilla/mozjpeg/archive/v${VERSION}.tar.gz ./

RUN apt-get update                                                             \
 && apt-get dist-upgrade -y                                                    \
 && apt-get install -y cmake nasm tar zlib1g-dev libpng-dev

RUN tar -xzf v${VERSION}.tar.gz                                                \
 && mv mozjpeg-${VERSION} src                                                  \
 && mkdir build/                                                               \
 && cd build/                                                                  \
 && cmake -G"Unix Makefiles" ../src/                                           \
 && make

# copy to target image
FROM ubuntu:latest
COPY --from=builder /src/mozjpeg/build/cjpeg-static /usr/local/bin/cjpeg
