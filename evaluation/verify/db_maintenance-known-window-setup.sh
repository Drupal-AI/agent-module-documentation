#!/usr/bin/env bash
# Introspection SETUP: enable the time interval with a known window 03:15-04:45. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("db_maintenance.settings")->set("use_time_interval", TRUE)->set("time_interval_start", "03:15")->set("time_interval_end", "04:45")->save();' >/dev/null 2>&1
echo "setup: db_maintenance window 03:15-04:45 (use_time_interval=true)"
