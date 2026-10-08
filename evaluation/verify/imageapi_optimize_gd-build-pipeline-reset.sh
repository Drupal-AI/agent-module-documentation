#!/usr/bin/env bash
# Execution RESET: ensure the pipeline "iaogd_task" does NOT exist, so verify FAILS on empty
# state until the agent creates it with a GD processor. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\imageapi_optimize\Entity\ImageAPIOptimizePipeline;
  if ($e = ImageAPIOptimizePipeline::load("iaogd_task")) { $e->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: pipeline iaogd_task absent"
