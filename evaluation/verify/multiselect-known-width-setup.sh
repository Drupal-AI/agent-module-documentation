#!/usr/bin/env bash
# Introspection SETUP: set multiselect box width to a known 400px. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("multiselect.settings")->set("multiselect.widths", 400)->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: multiselect.settings multiselect.widths=400"
