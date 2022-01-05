# disposable build image
# rebased/repackaged base image that only updates existing packages
FROM mbentley/alpine:latest AS build

RUN apk --no-cache add clang gcc git libc-dev make &&\
  cd tmp &&\
  git clone --depth 1 https://github.com/dennypage/dpinger.git &&\
  cd dpinger &&\
  make all

# end result
# rebased/repackaged base image that only updates existing packages
FROM mbentley/alpine:latest
LABEL maintainer="Matt Bentley <mbentley@mbentley.net>"

COPY --from=build /tmp/dpinger/dpinger /usr/local/bin/dpinger

ENTRYPOINT ["/usr/local/bin/dpinger","-f"]
