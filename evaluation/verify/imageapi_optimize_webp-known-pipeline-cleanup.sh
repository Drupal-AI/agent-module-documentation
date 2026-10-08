#!/usr/bin/env bash
# Config-factory delete avoids the pipeline entity flush (broken by remote_stream_wrapper on this site).
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("imageapi_optimize.pipeline.iow_intro")->delete();' >/dev/null 2>&1
echo "cleanup: pipeline iow_intro removed"
