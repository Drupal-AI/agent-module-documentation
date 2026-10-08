#!/usr/bin/env bash
# Introspection CLEANUP: restore the shipped default (empty allowlist). Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("sharedemail.settings")
    ->set("sharedemail_allowed", "")->save();
' >/dev/null 2>&1
echo "cleanup: sharedemail_allowed restored to empty (default)"
