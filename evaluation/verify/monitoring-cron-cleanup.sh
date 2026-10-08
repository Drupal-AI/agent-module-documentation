#!/usr/bin/env bash
# Execution CLEANUP: restore baseline - core_cron_last_run_age is enabled by default. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\monitoring\Entity\SensorConfig;
  if ($s = SensorConfig::load("core_cron_last_run_age")) { $s->set("status", TRUE); $s->save(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: core_cron_last_run_age re-enabled (baseline)"
