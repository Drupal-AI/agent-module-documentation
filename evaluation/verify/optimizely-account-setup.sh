#!/usr/bin/env bash
# Introspection SETUP: set a known Optimizely account ID so an agent can read it back.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush cset optimizely.settings optimizely_id 4242000 -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: optimizely.settings optimizely_id=4242000"
