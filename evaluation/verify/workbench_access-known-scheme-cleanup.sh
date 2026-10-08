#!/usr/bin/env bash
# Introspection CLEANUP for the workbench_access "known taxonomy scheme" medium cases.
# Restores baseline by deleting the wa_eval_editorial access_scheme created by
# workbench_access-known-scheme-setup.sh. Idempotent: a no-op if it is already gone.
set -uo pipefail
cd /var/www/html
drush php:eval '
  if ($e = \Drupal::entityTypeManager()->getStorage("access_scheme")->load("wa_eval_editorial")) { $e->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: access_scheme 'wa_eval_editorial' deleted (baseline restored)"
