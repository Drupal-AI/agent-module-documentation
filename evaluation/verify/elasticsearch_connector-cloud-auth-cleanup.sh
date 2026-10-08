#!/usr/bin/env bash
# Execution CLEANUP: remove the ec_cloud search_api.server built during the eval, restoring
# baseline (no server called ec_cloud). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("search_api.server.ec_cloud")->delete();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: search_api.server.ec_cloud removed"
