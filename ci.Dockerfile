# Dockerfile used for building linux/alpine binary
# https://github.com/anmonteiro/gh-feed-reader/blob/master/Dockerfile

# Node image where we install esy from npm
FROM node:16-alpine as build

ENV TERM=dumb
ENV LD_LIBRARY_PATH=/usr/local/lib:/usr/lib:/lib

RUN mkdir /esy
WORKDIR /esy

ENV NPM_CONFIG_PREFIX=/esy
RUN npm install -g --unsafe-perm esy@0.6.10

# Alpine image where
FROM alpine:3.8 as esy

ENV TERM=dumb
ENV LD_LIBRARY_PATH=/usr/local/lib:/usr/lib:/lib

WORKDIR /

COPY --from=build /esy /esy

RUN apk add --no-cache ca-certificates wget bash curl perl-utils git patch gcc g++ musl-dev make m4 coreutils tar xz linux-headers && \
    wget -q -O /etc/apk/keys/sgerrand.rsa.pub https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub && \
    wget -q https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.30-r0/glibc-2.30-r0.apk && \
    echo "@3.6 https://dl-cdn.alpinelinux.org/alpine/v3.6/main" >> /etc/apk/repositories && \
    apk add --no-cache libffi@3.6 glibc-2.30-r0.apk

ENV PATH=/esy/bin:$PATH

WORKDIR /app

ENTRYPOINT ["/bin/bash", "-c"]
