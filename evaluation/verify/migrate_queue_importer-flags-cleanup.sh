#!/usr/bin/env bash
# Introspection CLEANUP: delete mqi_flags. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '$s=\Drupal::entityTypeManager()->getStorage("cron_migration"); if($e=$s->load("mqi_flags")){$e->delete();}' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: cron_migration mqi_flags removed"
