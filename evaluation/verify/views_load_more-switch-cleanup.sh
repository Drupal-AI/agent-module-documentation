#!/usr/bin/env bash
# Execution CLEANUP: delete the vlm_task view. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '$v=\Drupal::entityTypeManager()->getStorage("view")->load("vlm_task"); if($v){$v->delete();}' >/dev/null 2>&1
echo "cleanup: view vlm_task removed"
