#!/usr/bin/env bash
# Execution RESET: clear all per-role expiration rules so verify FAILS until the agent adds the
# authenticated 90-day rule. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("user_expire.settings")->set("user_expire_roles", [])->save();
' >/dev/null 2>&1
echo "reset: user_expire_roles={} (no rules)"
