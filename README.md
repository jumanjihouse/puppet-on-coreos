Puppet on CoreOS
================

Project URL: https://github.com/jumanjihouse/puppet-on-coreos

Docker registry: https://registry.hub.docker.com/u/jumanjiman/puppet-on-coreos/


Overview
--------

Run Puppet inside a container such that it affects the state
of the underlying CoreOS host.

This git repo enables you to build docker images with the latest Puppet version
with these userspace distros:

* Alpine (41 MB)
* Centos7 (281 MB)


Wat? Why?
---------

Cloud-init is fine for bootstrapping CoreOS hosts, but sometimes you want to:

* consolidate inventory data (facter facts) in PuppetDB for all your hosts
* use a single cloud-config for all CoreOS hosts, then
  use Puppet to make minor config changes in an idempotent manner


How-to
------

Build images:

    script/build

Run simple tests (on a CoreOS host):

    script/test alpine
    script/test centos7

If you like the images, tag and push:

    docker tag puppet:alpine  <registry>/<id>/puppet-on-coreos:alpine
    docker tag puppet:centos7 <registry>/<id>/puppet-on-coreos:centos7


To-do
-----

Add fixtures and modify scripts to build and test on a hosted CI.
If CI tests pass, then push built images to Docker registry.


License
-------

See [LICENSE](LICENSE) in this git repo.
