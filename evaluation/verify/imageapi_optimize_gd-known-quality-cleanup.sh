#!/usr/bin/env bash
# Introspection CLEANUP: remove the pipeline created by the matching setup. Restores baseline
# (no iaogd_known pipeline). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\imageapi_optimize\Entity\ImageAPIOptimizePipeline;
  if ($e = ImageAPIOptimizePipeline::load("iaogd_known")) { $e->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: pipeline iaogd_known removed"
