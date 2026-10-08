#!/usr/bin/env bash
# Execution RESET: clear the "high-quality reSmush.it pipeline" task to empty state.
# Deletes the pipeline the task creates (id eval_resmushit_strict). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  if ($e = \Drupal::entityTypeManager()->getStorage("imageapi_optimize_pipeline")->load("eval_resmushit_strict")) { $e->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: imageapi_optimize.pipeline.eval_resmushit_strict removed"
