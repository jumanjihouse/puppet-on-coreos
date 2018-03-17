#!/bin/bash
set -e

. test/functions.bash

cat > ci/vars <<EOF
# This file (ci/vars) is automatically created by ci/build and
# is never checked into version control.

declare -rx PUPPET_VERSION=3.8.7

declare -rx BATS_VER=0.4.0

BUILD_DATE="$(date +%Y%m%dT%H%M)"
declare -rx BUILD_DATE

VCS_REF="$(git describe --dirty --tags --always --abbrev=7)"
declare -rx VCS_REF

TAG=\${PUPPET_VERSION}-\${BUILD_DATE}-git-\${VCS_REF}
declare -rx TAG
EOF

. ci/vars

options="
--rm
--build-arg PUPPET_VERSION=${PUPPET_VERSION}
--build-arg VCS_REF=${VCS_REF}
--build-arg BUILD_DATE=${BUILD_DATE}
"
echo $@ | grep '\--no-cache' &> /dev/null && options="$options --no-cache" || :

info "Build images."
smitty docker build $options -t puppet .

info "Show image sizes."
docker images | egrep '^puppet\b' | sort

echo
echo "WARN: you should docker tag the puppet image."
echo
