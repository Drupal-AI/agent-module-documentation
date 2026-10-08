#!/usr/bin/env bash
# Execution RESET: delete the advban.settings config object so the site is back to the
# advban post-install baseline (the module ships no config/install file) and verify FAILS.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("advban.settings")->delete();
' >/dev/null 2>&1
echo "reset: advban.settings deleted"
