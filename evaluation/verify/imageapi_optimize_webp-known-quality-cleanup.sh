#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("imageapi_optimize.pipeline.iow_quality")->delete();' >/dev/null 2>&1
echo "cleanup: pipeline iow_quality removed"
