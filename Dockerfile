# Build Gkds in a stock Go builder container
FROM golang:1.12-alpine as builder

RUN apk add --no-cache make gcc musl-dev linux-headers git

ADD . /go-kodabsdiuma
RUN cd /go-kodabsdiuma && make gkds

# Pull Gkds into a second stage deploy alpine container
FROM alpine:latest

RUN apk add --no-cache ca-certificates
COPY --from=builder /go-kodabsdiuma/build/bin/gkds /usr/local/bin/

EXPOSE 9931 9932 31540 31540/udp
ENTRYPOINT ["gkds"]
