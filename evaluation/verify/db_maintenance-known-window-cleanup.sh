#!/usr/bin/env bash
# Introspection CLEANUP: restore shipped defaults for the time interval. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("db_maintenance.settings")->set("use_time_interval", FALSE)->set("time_interval_start", "01:30")->set("time_interval_end", "02:30")->save();' >/dev/null 2>&1
echo "cleanup: db_maintenance time interval restored to defaults"
