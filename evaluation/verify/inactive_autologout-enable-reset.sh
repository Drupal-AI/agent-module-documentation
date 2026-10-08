#!/usr/bin/env bash
# Execution RESET: force autologout OFF with the default 120s timeout, so verify FAILS until the
# agent enables it and sets a 600s timeout. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("inactive_autologout.settings")
    ->set("enable", 0)->set("timeout", "120")->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: inactive_autologout enable=0 timeout=120"
