# disposable build image
FROM alpine:latest as build
MAINTAINER Matt Bentley <mbentley@mbentley.net>

RUN apk --no-cache add clang gcc git libc-dev make &&\
  cd tmp &&\
  git clone --depth 1 https://github.com/dennypage/dpinger.git &&\
  cd dpinger &&\
  make all

# end result
FROM alpine:latest
COPY --from=build /tmp/dpinger/dpinger /usr/local/bin/dpinger

ENTRYPOINT ["/usr/local/bin/dpinger","-f"]
