#!/usr/bin/env bash
# Execution RESET: delete the search_api.server config entity ec_cloud if it exists, so verify
# FAILS until the agent builds it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("search_api.server.ec_cloud")->delete();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: search_api.server.ec_cloud removed (does not exist)"
