#!/usr/bin/env bash
# Introspection CLEANUP: delete activities.settings to restore the shipped baseline (absent /
# nothing logged). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("activities.settings")->delete();' >/dev/null 2>&1
echo "cleanup: activities.settings removed (baseline)"
