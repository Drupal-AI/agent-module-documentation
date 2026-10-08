#!/usr/bin/env bash
# MEDIUM CLEANUP: restore shipped defaults (environment=test, empty live public key). Exit 0.
set -uo pipefail
cd /var/www/html
drush config:set stripe.settings environment test -y >/dev/null 2>&1
drush config:set stripe.settings apikey.live.public '' -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: stripe.settings restored (environment=test, apikey.live.public empty)"
