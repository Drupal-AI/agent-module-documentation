#!/usr/bin/env bash
# Execution RESET: remove watchdog_prune.settings so verify FAILS until the agent adds a
# php per-type rule. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("watchdog_prune.settings")->delete();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: watchdog_prune.settings removed"
