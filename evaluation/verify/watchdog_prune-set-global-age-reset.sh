#!/usr/bin/env bash
# Execution RESET: remove watchdog_prune.settings (baseline none) so verify FAILS until the
# agent sets a 3-month age. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("watchdog_prune.settings")->delete();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: watchdog_prune.settings removed"
