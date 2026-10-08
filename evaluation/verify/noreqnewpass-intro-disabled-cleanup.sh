#!/usr/bin/env bash
# Introspection CLEANUP: restore baseline — noreqnewpass_disable back to FALSE (install
# default; module inert). Idempotent. Rebuilds routes. Exits 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("noreqnewpass.settings_form")
    ->set("noreqnewpass_disable", FALSE)->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: noreqnewpass.settings_form:noreqnewpass_disable = FALSE (baseline)"
