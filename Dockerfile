FROM alpine:latest

# Puppet absolutely needs the shadow utils, such as useradd.
RUN echo http://dl-4.alpinelinux.org/alpine/edge/testing/ >> /etc/apk/repositories
RUN apk upgrade --update --available && \
    apk add \
      ca-certificates \
      ruby \
      util-linux \
      shadow \
    && rm -f /var/cache/apk/* && \
    gem install -N \
      facter:'>= 2.4.3' \
      puppet:'< 4.0' \
    && rm -fr /root/.gem

ENV container docker
VOLUME ["/sys/fs/cgroup", "/run", "/var/lib/puppet", "/lib64"]

ENTRYPOINT ["/usr/bin/puppet"]
CMD ["help"]
