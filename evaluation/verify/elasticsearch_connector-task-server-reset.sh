#!/usr/bin/env bash
# Execution RESET: delete the search_api.server config entity ec_task if it exists, so verify
# FAILS until the agent builds it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("search_api.server.ec_task")->delete();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: search_api.server.ec_task removed (does not exist)"
