#!/usr/bin/env bash
# Introspection CLEANUP: remove the known eval_ld_known lang_dropdown block, restoring
# baseline. Idempotent: no-op if already gone. Exits 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $b = \Drupal::entityTypeManager()->getStorage("block")->load("eval_ld_known");
  if ($b) { $b->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: block eval_ld_known removed"
