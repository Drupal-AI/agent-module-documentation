#!/usr/bin/env bash
# Introspection CLEANUP: delete the known `mf_eval_known` migration config entity, restoring
# baseline. Idempotent: no-op if already gone. Exits 0. Paths relative to /var/www/html.
set -uo pipefail
cd /var/www/html
drush php:eval '
  if ($m = \Drupal::entityTypeManager()->getStorage("migration")->load("mf_eval_known")) { $m->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: migrate_plus.migration.mf_eval_known removed"
