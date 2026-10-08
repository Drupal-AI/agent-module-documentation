#!/usr/bin/env bash
# Introspection CLEANUP: delete the vlm_finish view. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '$v=\Drupal::entityTypeManager()->getStorage("view")->load("vlm_finish"); if($v){$v->delete();}' >/dev/null 2>&1
echo "cleanup: view vlm_finish removed"
