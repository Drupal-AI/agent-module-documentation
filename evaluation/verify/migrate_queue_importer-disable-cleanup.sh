#!/usr/bin/env bash
# Execution CLEANUP: delete mqi_toggle. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '$s=\Drupal::entityTypeManager()->getStorage("cron_migration"); if($e=$s->load("mqi_toggle")){$e->delete();}' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: cron_migration mqi_toggle removed"
