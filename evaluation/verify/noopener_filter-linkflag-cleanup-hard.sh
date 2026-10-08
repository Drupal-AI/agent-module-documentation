#!/usr/bin/env bash
# Execution CLEANUP: remove the noopener_filter.settings config object, restoring the shipped
# baseline (global link-alter off). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("noopener_filter.settings")->delete();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: noopener_filter.settings deleted"
