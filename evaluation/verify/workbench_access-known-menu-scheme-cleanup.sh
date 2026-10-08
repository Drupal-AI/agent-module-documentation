#!/usr/bin/env bash
# Introspection CLEANUP for the workbench_access "known menu scheme" medium case.
# Restores baseline by deleting the wa_eval_nav access_scheme created by
# workbench_access-known-menu-scheme-setup.sh. Idempotent: a no-op if already gone.
set -uo pipefail
cd /var/www/html
drush php:eval '
  if ($e = \Drupal::entityTypeManager()->getStorage("access_scheme")->load("wa_eval_nav")) { $e->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: access_scheme 'wa_eval_nav' deleted (baseline restored)"
