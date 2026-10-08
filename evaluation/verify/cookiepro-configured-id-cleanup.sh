#!/usr/bin/env bash
# Introspection CLEANUP: delete the cookiepro.header.settings config object to restore the
# shipped baseline (no config exists until the form is saved). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("cookiepro.header.settings")->delete();
' >/dev/null 2>&1
echo "cleanup: cookiepro.header.settings deleted (baseline restored)"
