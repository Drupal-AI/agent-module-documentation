#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush config:set stripe.settings environment test -y >/dev/null 2>&1
drush config:set stripe.settings apikey.live.public '' -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: stripe.settings restored to defaults"
