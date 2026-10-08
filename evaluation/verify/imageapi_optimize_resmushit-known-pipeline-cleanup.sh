#!/usr/bin/env bash
# Introspection CLEANUP: remove the known pipeline (id eval_resmushit_known), restoring
# baseline. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  if ($e = \Drupal::entityTypeManager()->getStorage("imageapi_optimize_pipeline")->load("eval_resmushit_known")) { $e->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: imageapi_optimize.pipeline.eval_resmushit_known removed"
