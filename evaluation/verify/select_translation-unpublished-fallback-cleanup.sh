#!/usr/bin/env bash
# Introspection CLEANUP: delete the throwaway view created by the matching setup script,
# restoring baseline (no st_eval_unpub view). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  if ($v = \Drupal::entityTypeManager()->getStorage("view")->load("st_eval_unpub")) { $v->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: view st_eval_unpub removed"
