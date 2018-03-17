#!/bin/bash
set -eEu
set -o pipefail

# shellcheck disable=SC1091
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

# shellcheck disable=SC1091
. ci/vars

options="
--rm
--build-arg PUPPET_VERSION=${PUPPET_VERSION}
--build-arg VCS_REF=${VCS_REF}
--build-arg BUILD_DATE=${BUILD_DATE}
"
if echo "$@" | grep '\--no-cache' &> /dev/null; then
  options="$options --no-cache"
fi
readonly options

info "Build images."
# shellcheck disable=SC2086
smitty docker build $options -t puppet .

info "Show image sizes."
docker images | grep -E '^puppet\b' | sort

echo
echo "WARN: you should docker tag the puppet image."
echo
