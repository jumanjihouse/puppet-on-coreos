Puppet v3 on CoreOS
===================

[![](https://imagelayers.io/badge/jumanjiman/puppet:latest.svg)](https://imagelayers.io/?images=jumanjiman/puppet:latest 'View on imagelayers.io')&nbsp;
[![Docker Registry](https://img.shields.io/docker/pulls/jumanjiman/puppet.svg)](https://registry.hub.docker.com/u/jumanjiman/puppet)&nbsp;
[![Circle CI](https://circleci.com/gh/jumanjihouse/puppet-on-coreos.png?circle-token=f9208a48c93c066eedc085afb8e79fd6d2f6c6a4)](https://circleci.com/gh/jumanjihouse/puppet-on-coreos/tree/master 'View CI builds')

Project URL: https://github.com/jumanjihouse/puppet-on-coreos

Docker registry: https://registry.hub.docker.com/u/jumanjiman/puppet/


Overview
--------

Run Puppet inside a container such that it affects the state
of the underlying CoreOS host.

This repo and docker image tracks the latest Puppet 3.x version.
If you want an image that tracks Puppet 4.x, see the
[PuppetLabs repo](https://github.com/puppetlabs/puppet-in-docker/tree/master/puppet-agent-alpine).

If you want to run Puppet Master in a container, see
[my docker-puppet git repo](https://github.com/jumanjiman/docker-puppet).


Wat? Why?
---------

Cloud-init is fine for bootstrapping CoreOS hosts, but sometimes you want to:

* consolidate inventory data (facter facts) in PuppetDB for all your hosts
* use a single cloud-config for all CoreOS hosts, then
  use Puppet to make minor config changes in an idempotent manner

See also these blog posts:

* [Using Puppet with CoreOS, rkt, Flannel and etcd](https://puppet.com/blog/using-puppet-coreos-rkt-flannel-and-etcd)
* [Puppet in Docker: running Puppet on container-centric infrastructure](https://puppet.com/blog/puppet-docker-running-puppet-container-centric-infrastructure)


How-to
------

Build images:

    script/build

Run simple tests:

    script/test

The test harness uses [BATS](https://github.com/sstephenson/bats).
Output resembles:

    1..6
    ok 1 list users inside container
    ok 2 list groups inside container
    ok 3 # skip (requires systemctl) manipulate systemd on host OS
    ok 4 facter works against host OS
    ok 5 show puppet help
    ok 6 puppet works against host OS


License
-------

See [LICENSE](LICENSE) in this git repo.
