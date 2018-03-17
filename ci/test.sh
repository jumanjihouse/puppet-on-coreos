#!/bin/bash
set -e

. ci/vars

bats test/*.bats
