#!/usr/bin/env bash
# Execution CLEANUP: delete the throwaway view used by the add-original case, leaving the
# site clean. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  if ($v = \Drupal::entityTypeManager()->getStorage("view")->load("st_eval_add")) { $v->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: view st_eval_add removed"
