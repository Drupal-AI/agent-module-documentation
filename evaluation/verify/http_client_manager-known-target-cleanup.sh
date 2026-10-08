#!/usr/bin/env bash
# Introspection CLEANUP: delete http_config_request hcm_eval_m2. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '$s=\Drupal::entityTypeManager()->getStorage("http_config_request"); if($e=$s->load("hcm_eval_m2")){$e->delete();}' >/dev/null 2>&1
echo "cleanup: hcm_eval_m2 removed"
