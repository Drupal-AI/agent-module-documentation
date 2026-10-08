#!/usr/bin/env bash
# Introspection CLEANUP: restore the shipped defaults for the touched keys. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("iubenda_integration.settings")
    ->set("iubenda_integration_policy_code", "")
    ->set("iubenda_integration_style", "iubenda-nostyle")
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: iubenda_integration.settings policy code/style restored to defaults"
