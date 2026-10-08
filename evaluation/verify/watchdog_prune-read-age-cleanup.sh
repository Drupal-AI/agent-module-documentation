#!/usr/bin/env bash
# Cleanup: delete the watchdog_prune.settings config (baseline = does not exist). Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("watchdog_prune.settings")->delete();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: watchdog_prune.settings removed"
