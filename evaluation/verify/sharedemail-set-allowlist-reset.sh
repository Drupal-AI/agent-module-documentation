#!/usr/bin/env bash
# Execution RESET: clear the Shared Email allowlist so verify FAILS until the agent sets it. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("sharedemail.settings")
    ->set("sharedemail_allowed", "")->save();
' >/dev/null 2>&1
echo "reset: sharedemail_allowed cleared"
