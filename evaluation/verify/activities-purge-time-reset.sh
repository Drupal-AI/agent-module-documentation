#!/usr/bin/env bash
# Execution RESET: remove activities.settings so no purge policy is set and verify FAILS until
# the agent configures a 90-day time-based purge. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("activities.settings")->delete();' >/dev/null 2>&1
echo "reset: activities.settings removed (no purge policy)"
