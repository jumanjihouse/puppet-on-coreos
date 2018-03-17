#!/bin/bash
set -eEu
set -o pipefail

. ci/vars

docker login -u "${user}" -p "${pass}"

# Pessimistic tag.
docker tag puppet "jumanjiman/puppet:${TAG}"
docker push "jumanjiman/puppet:${TAG}"

# Optimistic tag.
docker tag puppet jumanjiman/puppet:latest
docker push jumanjiman/puppet:latest

docker logout

# Update https://microbadger.com/images/jumanjiman/puppet
#
curl -X POST 'https://hooks.microbadger.com/images/jumanjiman/puppet/28hXfM14w5i9q_1-yusNB2y5jLQ='
