#!/usr/bin/env bash
# HARD execution RESET: clear the test webhook signing secret so verify FAILs until the agent
# sets it. Exit 0.
set -uo pipefail
cd /var/www/html
drush config:set stripe.settings apikey.test.webhook '' -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: stripe.settings apikey.test.webhook empty"
