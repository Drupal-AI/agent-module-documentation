#!/usr/bin/env bash
# Introspection SETUP: set watchdog_prune global age to -6 MONTHS. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("watchdog_prune.settings")
    ->set("watchdog_prune_age", "-6 MONTHS")
    ->set("watchdog_prune_age_type", "")
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: watchdog_prune.settings watchdog_prune_age = -6 MONTHS"
