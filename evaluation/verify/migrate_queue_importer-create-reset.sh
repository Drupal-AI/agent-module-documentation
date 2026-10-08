#!/usr/bin/env bash
# Execution RESET: ensure cron_migration mqi_task does NOT exist, so verify FAILS until built.
set -uo pipefail
cd /var/www/html
drush php:eval '$s=\Drupal::entityTypeManager()->getStorage("cron_migration"); if($e=$s->load("mqi_task")){$e->delete();}' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: cron_migration mqi_task absent"
