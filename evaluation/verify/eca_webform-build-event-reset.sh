#!/usr/bin/env bash
# Execution RESET: ensure ECA model ecawf_task2 does NOT exist (verify FAILS on empty). Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '$s=\Drupal::entityTypeManager()->getStorage("eca"); if($e=$s->load("ecawf_task2")){$e->delete();}' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: eca model ecawf_task2 absent"
