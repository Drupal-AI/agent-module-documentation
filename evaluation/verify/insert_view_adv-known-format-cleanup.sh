#!/usr/bin/env bash
# Introspection CLEANUP: delete the iva_eval text format. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '$f=\Drupal::entityTypeManager()->getStorage("filter_format")->load("iva_eval"); if($f){$f->delete();}' >/dev/null 2>&1
echo "cleanup: text format iva_eval removed"
