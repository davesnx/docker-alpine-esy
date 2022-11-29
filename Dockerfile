# Dockerfile used for building linux/alpine binary
# https://github.com/anmonteiro/gh-feed-reader/blob/master/Dockerfile

# Node image where we install esy from npm
FROM node:16.3-alpine3.12 as build

ENV TERM=dumb
ENV LD_LIBRARY_PATH=/usr/local/lib:/usr/lib:/lib

RUN set NODE_OPTIONS=--max-old-space-size=30720

RUN mkdir /esy
WORKDIR /esy

ENV NPM_CONFIG_PREFIX=/esy
RUN npm install esy@0.6.12

# Alpine image where
FROM alpine:3.8 as esy

ENV TERM=dumb
ENV LD_LIBRARY_PATH=/usr/local/lib:/usr/lib:/lib

WORKDIR /

COPY --from=build /esy /esy

RUN apk add --no-cache ca-certificates wget bash curl perl-utils git patch gcc g++ musl-dev make m4 coreutils tar xz linux-headers

RUN wget -q -O /etc/apk/keys/sgerrand.rsa.pub https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub
RUN wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.28-r0/glibc-2.28-r0.apk
RUN apk add --no-cache glibc-2.28-r0.apk

ENV PATH=/esy/bin:$PATH

WORKDIR /app

ENTRYPOINT ["/bin/bash", "-c"]
