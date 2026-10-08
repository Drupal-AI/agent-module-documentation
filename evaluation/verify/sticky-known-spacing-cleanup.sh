#!/usr/bin/env bash
# Introspection CLEANUP: delete sticky.settings to restore baseline (absent config).
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("sticky.settings")->delete();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: sticky.settings removed"
