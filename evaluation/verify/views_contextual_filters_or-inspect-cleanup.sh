#!/usr/bin/env bash
# Introspection CLEANUP: delete the known `vcfo_eval_known` view, restoring baseline.
# Idempotent: no-op if already gone. Exits 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  if ($v = \Drupal\views\Entity\View::load("vcfo_eval_known")) { $v->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: view vcfo_eval_known deleted"
