#!/usr/bin/env bash
# Execution RESET: clear copyprevention_body (all body deterrents OFF), so verify FAILS until the
# agent enables the right-click/context-menu deterrent. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("copyprevention.settings")->clear("copyprevention_body")->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: copyprevention_body cleared (no body deterrents)"
