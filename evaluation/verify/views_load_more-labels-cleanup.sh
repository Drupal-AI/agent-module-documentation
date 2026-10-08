#!/usr/bin/env bash
# Execution CLEANUP: delete the vlm_labels view. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '$v=\Drupal::entityTypeManager()->getStorage("view")->load("vlm_labels"); if($v){$v->delete();}' >/dev/null 2>&1
echo "cleanup: view vlm_labels removed"
