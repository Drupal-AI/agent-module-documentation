#!/usr/bin/env bash
# MEDIUM introspection cleanup: restore system.site slogan to its empty baseline.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("system.site")->set("slogan", "")->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: system.site slogan restored to baseline (empty)"
