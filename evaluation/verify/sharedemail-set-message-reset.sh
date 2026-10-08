#!/usr/bin/env bash
# Execution RESET: set the warning message to a baseline sentinel (NOT the target) so verify FAILS until
# the agent sets the requested text. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("sharedemail.settings")
    ->set("sharedemail_msg", "SHAREDEMAIL_RESET_BASELINE_DO_NOT_MATCH")->save();
' >/dev/null 2>&1
echo "reset: sharedemail_msg set to baseline sentinel"
