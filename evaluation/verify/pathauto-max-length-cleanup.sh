#!/usr/bin/env bash
# Introspection CLEANUP: restore Pathauto's max_length to its baseline default 150.
# Idempotent. Exits 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("pathauto.settings")->set("max_length", 150)->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: pathauto.settings max_length restored to 150"
