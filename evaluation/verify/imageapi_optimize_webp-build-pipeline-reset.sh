#!/usr/bin/env bash
# Execution RESET: remove pipeline iow_task so verify FAILS until the agent creates an Image Optimize
# pipeline containing the WebP Deriver processor at quality 80. Uses config-factory delete to avoid
# the pipeline entity flush (broken by remote_stream_wrapper on this site).
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("imageapi_optimize.pipeline.iow_task")->delete();' >/dev/null 2>&1
echo "reset: pipeline iow_task removed"
