#!/usr/bin/env bash
# Execution CLEANUP: delete cookiepro.header.settings to restore baseline. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("cookiepro.header.settings")->delete();
' >/dev/null 2>&1
echo "cleanup: cookiepro.header.settings deleted (baseline restored)"
