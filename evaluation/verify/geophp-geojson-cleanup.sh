#!/usr/bin/env bash
# Execution CLEANUP: delete the geophp_eval_geojson state key. Idempotent. Exit 0.
# converts the point to GeoJSON and stores it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::state()->delete("geophp_eval_geojson");' >/dev/null 2>&1
echo "cleanup: state geophp_eval_geojson deleted"
