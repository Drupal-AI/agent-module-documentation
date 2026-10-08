#!/usr/bin/env bash
# Introspection CLEANUP: delete the advban.settings config object written by the matching
# setup. advban ships no config/install/advban.settings.yml, so "no config object" IS the
# post-install baseline. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("advban.settings")->delete();
' >/dev/null 2>&1
echo "cleanup: advban.settings deleted (back to post-install baseline)"
