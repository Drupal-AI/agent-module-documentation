#!/usr/bin/env bash
# Introspection CLEANUP: remove config_inspector_test.settings. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("config_inspector_test.settings")->delete();' >/dev/null 2>&1
echo "cleanup: config_inspector_test.settings removed"
