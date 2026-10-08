#!/usr/bin/env bash
# Introspection CLEANUP: restore automated_cron.settings:interval to its default 10800. Leaves
# automated_cron enabled (site default). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush config:set automated_cron.settings interval 10800 -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: automated_cron.settings:interval restored to 10800"
