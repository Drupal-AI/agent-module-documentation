#!/usr/bin/env bash
# Execution RESET: force multiselect width back to default 250 so verify (wants 320) FAILS. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("multiselect.settings")->set("multiselect.widths", 250)->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: multiselect.widths=250"
