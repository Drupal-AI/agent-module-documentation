#!/usr/bin/env bash
# Execution CLEANUP: delete the vsf_eval_hard view. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '$v=\Drupal::entityTypeManager()->getStorage("view")->load("vsf_eval_hard"); if($v){$v->delete();}' >/dev/null 2>&1
echo "cleanup: view vsf_eval_hard removed"
