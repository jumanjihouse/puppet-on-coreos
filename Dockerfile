FROM gliderlabs/alpine

# Puppet absolutely needs the shadow utils, such as useradd.
RUN echo http://dl-4.alpinelinux.org/alpine/edge/testing/ >> /etc/apk/repositories
RUN apk-install ca-certificates ruby util-linux shadow
RUN gem install -N facter puppet && rm -fr /root/.gem

# Patch facter to use /etc/os-release on coreos.
# https://github.com/puppetlabs/facter/pull/866
ADD https://raw.githubusercontent.com/jumanjiman/facter/coreos_2x/lib/facter/operatingsystem/implementation.rb /usr/lib/ruby/gems/2.1.0/gems/facter-2.4.0/lib/facter/operatingsystem/implementation.rb
ADD https://raw.githubusercontent.com/jumanjiman/facter/coreos_2x/lib/facter/operatingsystem/osreleaselinux.rb  /usr/lib/ruby/gems/2.1.0/gems/facter-2.4.0/lib/facter/operatingsystem/osreleaselinux.rb

ENV container docker
VOLUME ["/sys/fs/cgroup", "/run", "/var/lib/puppet", "/lib64"]

ENTRYPOINT ["/usr/bin/puppet"]
CMD ["help"]
