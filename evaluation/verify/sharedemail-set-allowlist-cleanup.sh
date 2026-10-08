#!/usr/bin/env bash
# Execution CLEANUP: restore empty allowlist (default). Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("sharedemail.settings")
    ->set("sharedemail_allowed", "")->save();
' >/dev/null 2>&1
echo "cleanup: sharedemail_allowed restored to empty (default)"
