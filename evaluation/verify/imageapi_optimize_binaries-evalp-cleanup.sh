#!/usr/bin/env bash
# Introspection CLEANUP: delete the imageapi_bin_evalp pipeline. Restores baseline. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval 'if ($p = \Drupal::entityTypeManager()->getStorage("imageapi_optimize_pipeline")->load("imageapi_bin_evalp")) { $p->delete(); }' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: pipeline imageapi_bin_evalp removed"
