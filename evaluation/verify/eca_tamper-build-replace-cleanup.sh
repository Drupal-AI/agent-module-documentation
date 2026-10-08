#!/usr/bin/env bash
# Execution CLEANUP: delete ECA model ectamp_task2. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '$s=\Drupal::entityTypeManager()->getStorage("eca"); if($e=$s->load("ectamp_task2")){$e->delete();}' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: eca model ectamp_task2 removed"
