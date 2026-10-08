#!/usr/bin/env bash
# Execution RESET: clear the geophp_eval_geojson state key so verify FAILS until the agent
# converts the point to GeoJSON and stores it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::state()->delete("geophp_eval_geojson");' >/dev/null 2>&1
echo "reset: state geophp_eval_geojson cleared"
