#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush config:set stripe.settings apikey.test.public '' -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: stripe.settings apikey.test.public emptied"
