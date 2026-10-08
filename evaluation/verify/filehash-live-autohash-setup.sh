#!/usr/bin/env bash
# Introspection SETUP: turn on filehash autohash so an inspecting agent can read the value.
# Baseline default is false. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush config:set filehash.settings autohash 1 -y >/dev/null 2>&1
echo "setup: filehash.settings autohash=true"
