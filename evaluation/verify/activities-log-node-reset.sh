#!/usr/bin/env bash
# Execution RESET: remove activities.settings entirely, so nothing is logged and verify FAILS
# until the agent enables node create+delete logging. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("activities.settings")->delete();' >/dev/null 2>&1
echo "reset: activities.settings removed (no logging)"
