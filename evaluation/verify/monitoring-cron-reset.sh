#!/usr/bin/env bash
# Execution RESET: disable the core_cron_last_run_age sensor (status: false) so verify FAILS until the
# agent enables it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\monitoring\Entity\SensorConfig;
  if ($s = SensorConfig::load("core_cron_last_run_age")) { $s->set("status", FALSE); $s->save(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: core_cron_last_run_age disabled"
