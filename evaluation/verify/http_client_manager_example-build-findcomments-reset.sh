#!/usr/bin/env bash
# Execution RESET/CLEANUP: ensure hcme_eval_build does NOT exist so verify FAILS. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '$s=\Drupal::entityTypeManager()->getStorage("http_config_request"); if($e=$s->load("hcme_eval_build")){$e->delete();}' >/dev/null 2>&1
echo "reset: hcme_eval_build absent"
