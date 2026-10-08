#!/usr/bin/env bash
# Execution RESET/CLEANUP: ensure http_config_request hcm_eval_h1 does NOT exist so verify FAILS.
set -uo pipefail
cd /var/www/html
drush php:eval '$s=\Drupal::entityTypeManager()->getStorage("http_config_request"); if($e=$s->load("hcm_eval_h1")){$e->delete();}' >/dev/null 2>&1
echo "reset: hcm_eval_h1 absent"
