#!/usr/bin/env bash
# Introspection CLEANUP: delete the vcct_eval_plugin view created by the matching setup.
# Idempotent. Exits 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  if ($v = \Drupal::entityTypeManager()->getStorage("view")->load("vcct_eval_plugin")) { $v->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: view vcct_eval_plugin deleted"
