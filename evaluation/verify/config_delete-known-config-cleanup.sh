#!/usr/bin/env bash
# Introspection CLEANUP: delete config_delete_known.settings. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("config_delete_known.settings")->delete();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: config_delete_known.settings removed"
