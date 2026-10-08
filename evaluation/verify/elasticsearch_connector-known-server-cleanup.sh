#!/usr/bin/env bash
# Introspection CLEANUP: remove the ec_known search_api.server config written by the matching
# setup, restoring baseline (no server called ec_known). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("search_api.server.ec_known")->delete();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: search_api.server.ec_known removed"
