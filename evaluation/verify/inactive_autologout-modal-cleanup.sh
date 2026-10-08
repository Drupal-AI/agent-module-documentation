#!/usr/bin/env bash
# Introspection CLEANUP: restore the shipped default modal title. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("inactive_autologout.settings")
    ->set("modal_title", "Session Expiring")->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: inactive_autologout modal_title restored to Session Expiring"
