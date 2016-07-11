FROM alpine:3.4

# Puppet absolutely needs the shadow utils, such as useradd.
RUN echo http://dl-4.alpinelinux.org/alpine/edge/testing/ >> /etc/apk/repositories

# Get access to ruby < 2.2 to avoid syck errors on puppet 3.x
RUN echo http://dl-4.alpinelinux.org/alpine/v3.1/main/ >> /etc/apk/repositories

RUN apk upgrade --update --available && \
    apk add --no-cache -X http://dl-4.alpinelinux.org/alpine/edge/main/ \
      'openssl>=1.0.2h-r1' \
      && \
    apk add \
      ca-certificates \
      pciutils \
      'ruby<2.2' \
      util-linux \
      shadow \
    && rm -f /var/cache/apk/* && \
    gem install -N \
      facter:'>= 2.4.6' \
      puppet:'= 3.8.7' \
    && rm -fr /root/.gem

RUN rm -fr /var/spool/cron/crontabs/* && \
    :

ENV container docker
VOLUME ["/sys/fs/cgroup", "/run", "/var/lib/puppet", "/lib64"]

ENTRYPOINT ["/usr/bin/puppet"]
CMD ["help"]
