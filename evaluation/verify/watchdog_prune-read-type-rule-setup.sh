#!/usr/bin/env bash
# Introspection SETUP: set a per-type prune rule php|-1 MONTH (plus a system rule). Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("watchdog_prune.settings")
    ->set("watchdog_prune_age", "-18 MONTHS")
    ->set("watchdog_prune_age_type", "php|-1 MONTH\nsystem|-3 MONTHS")
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: watchdog_prune per-type rule php|-1 MONTH"
