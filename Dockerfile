FROM golang:1.13 AS build

WORKDIR /go/src/github.com/analogj/lodestone-fuse
COPY . .

RUN go build $(go list ./cmd/...)

CMD ["lodestone-fuse"]

FROM ubuntu:12.04

RUN apt-get update -qq
RUN apt-get install -y build-essential libfuse-dev fuse-utils libcurl4-openssl-dev libxml2-dev mime-support automake libtool wget tar

COPY --from=build /go/src/github.com/analogj/lodestone-fuse/lodestone-fuse /usr/bin/lodestone-fuse

RUN mkdir -p /tmp/lode-fuse

CMD ["lodestone-fuse", "mount", "--dir", "/tmp/lode-fuse"]
