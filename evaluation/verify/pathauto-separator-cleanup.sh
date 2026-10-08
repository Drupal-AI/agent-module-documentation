#!/usr/bin/env bash
# Introspection CLEANUP: restore the Pathauto word separator to its baseline "-" (hyphen).
# Idempotent. Exits 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("pathauto.settings")->set("separator", "-")->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: pathauto.settings separator restored to - (hyphen)"
