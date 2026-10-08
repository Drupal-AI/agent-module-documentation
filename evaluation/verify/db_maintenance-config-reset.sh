#!/usr/bin/env bash
# Execution RESET / CLEANUP: restore all db_maintenance.settings keys to shipped defaults so
# verify FAILS on this baseline. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("db_maintenance.settings")
    ->set("cron_frequency", 86400)
    ->set("use_time_interval", FALSE)
    ->set("time_interval_start", "01:30")
    ->set("time_interval_end", "02:30")
    ->set("all_tables", FALSE)
    ->set("write_log", FALSE)
    ->save();
' >/dev/null 2>&1
echo "reset: db_maintenance.settings restored to shipped defaults"
