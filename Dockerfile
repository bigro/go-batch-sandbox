FROM golang:alpine AS build-stage
RUN apk add --update && apk add git
ADD . /work
WORKDIR /work
RUN GOOS=linux GOARCH=amd64 go build -o entrypoint .

FROM alpine:latest
COPY --from=build-stage /work/entrypoint /usr/local/bin/entrypoint
ENTRYPOINT ["/usr/local/bin/entrypoint"]
