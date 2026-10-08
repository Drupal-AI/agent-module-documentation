#!/usr/bin/env bash
# Execution RESET: remove pipeline iowr_task so verify FAILS until the agent creates a pipeline with
# the WebP Deriver processor (what imageapi_optimize_webp_responsive needs to emit WebP sources).
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("imageapi_optimize.pipeline.iowr_task")->delete();' >/dev/null 2>&1
echo "reset: pipeline iowr_task removed"
