#!/usr/bin/env bash
# Execution CLEANUP: delete wcc_edit. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '$s=\Drupal::entityTypeManager()->getStorage("webform_content_creator"); if($e=$s->load("wcc_edit")){$e->delete();}' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: wcc_edit removed"
