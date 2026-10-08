#!/usr/bin/env bash
# Introspection CLEANUP: delete url_redirect rule urlr_role. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '$s=\Drupal::entityTypeManager()->getStorage("url_redirect"); if($e=$s->load("urlr_role")){$e->delete();}' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: url_redirect urlr_role removed"
