#!/usr/bin/env bash
# Introspection CLEANUP: restore shipped defaults (enable=0, timeout=120). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("inactive_autologout.settings")
    ->set("enable", 0)->set("timeout", "120")->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: inactive_autologout enable=0 timeout=120 (defaults restored)"
