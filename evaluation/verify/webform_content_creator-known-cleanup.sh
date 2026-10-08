#!/usr/bin/env bash
# Introspection CLEANUP: delete wcc_known. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '$s=\Drupal::entityTypeManager()->getStorage("webform_content_creator"); if($e=$s->load("wcc_known")){$e->delete();}' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: wcc_known removed"
