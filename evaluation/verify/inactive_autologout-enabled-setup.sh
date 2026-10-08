#!/usr/bin/env bash
# Introspection SETUP: enable autologout with a known default timeout (300s) so an inspecting
# agent can read back that it is on and its timeout. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("inactive_autologout.settings")
    ->set("enable", 1)->set("timeout", "300")->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: inactive_autologout enable=1 timeout=300"
