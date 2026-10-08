#!/usr/bin/env bash
# Execution RESET: ensure pipeline "imageapi_bin_eval" does NOT exist, so verify FAILS until the
# agent builds it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval 'if ($p = \Drupal::entityTypeManager()->getStorage("imageapi_optimize_pipeline")->load("imageapi_bin_eval")) { $p->delete(); }' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: pipeline imageapi_bin_eval absent"
