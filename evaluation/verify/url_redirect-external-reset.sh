#!/usr/bin/env bash
# Execution RESET: ensure url_redirect rule urlr_ext does NOT exist. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '$s=\Drupal::entityTypeManager()->getStorage("url_redirect"); if($e=$s->load("urlr_ext")){$e->delete();}' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: url_redirect urlr_ext absent"
