#!/usr/bin/env bash
# Introspection CLEANUP: delete the vlm_known view. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '$v=\Drupal::entityTypeManager()->getStorage("view")->load("vlm_known"); if($v){$v->delete();}' >/dev/null 2>&1
echo "cleanup: view vlm_known removed"
