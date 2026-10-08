#!/usr/bin/env bash
# Execution RESET for "turn on admin_routes": force admin_routes OFF in the module config so
# verify FAILS until the agent enables it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("administration_language_negotiation.negotiation")
    ->set("admin_routes", FALSE)->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: admin_routes = false"
