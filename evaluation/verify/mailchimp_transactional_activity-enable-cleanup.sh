#!/usr/bin/env bash
# Execution CLEANUP: delete the mta_toggle Activity mapping. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '$s=\Drupal::entityTypeManager()->getStorage("mailchimp_transactional_activity"); if($e=$s->load("mta_toggle")){$e->delete();}' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: mta_toggle removed"
