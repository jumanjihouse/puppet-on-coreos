load functions

@test "list users inside container" {
  run docker_run puppet getent passwd
  [[ ${output} =~ 'bin:x:1:1:bin:/bin:/sbin/nologin' ]]
}

@test "list groups inside container" {
  run docker_run puppet getent group
  [[ ${output} =~ 'bin:x:1:root,bin,daemon' ]]
}

@test "manipulate systemd on host OS" {
  [ $(command -v systemctl) ] || skip 'requires systemctl'
  run docker_run puppet systemctl status systemd-journald
  [ ${status} -eq 0 ]
}

@test "facter works against host OS" {
  docker_run puppet facter operatingsystem
  docker_run puppet facter osfamily
}

@test "show puppet help" {
  run docker run --rm ${volumes} puppet
  [ ${status} -eq 0 ]
  [[ ${output} =~ 'Available subcommands' ]]
}

@test "puppet works against host OS" {
  # Disable network and UTS namespaces since we store puppet cert on host.
  run docker run --rm $volumes --net host puppet \
    apply $debug $trace -e 'file {"/etc/bar/foo": ensure => file, content => "bar\n", } notify {"$::operatingsystem":}'
  [ ${status} -eq 0 ]
  [[ ${output} =~ 'Compiled catalog' ]]
  [[ ${output} =~ 'Finished catalog run' ]]

  sudo mkdir /etc/bar &> /dev/null || :
  run docker run --rm -v /etc/bar:/etc/bar alpine:3.3 cat /etc/bar/foo
  [ ${status} -eq 0 ]
  [[ ${lines[0]} =~ ^bar$ ]]
}
