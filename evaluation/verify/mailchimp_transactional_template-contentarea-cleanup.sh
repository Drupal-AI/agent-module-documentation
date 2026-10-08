#!/usr/bin/env bash
# Execution CLEANUP: delete the mtt_edit Template Map. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '$s=\Drupal::entityTypeManager()->getStorage("mailchimp_transactional_template"); if($e=$s->load("mtt_edit")){$e->delete();}' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: mtt_edit removed"
