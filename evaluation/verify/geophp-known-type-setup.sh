#!/usr/bin/env bash
# Introspection SETUP: store a known WKT linestring in Drupal state (geophp_eval_input2) so an
# agent can read it and identify its geometry type via geophp. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::state()->set("geophp_eval_input2", "LINESTRING(0 0,3 4)");' >/dev/null 2>&1
echo "setup: state geophp_eval_input2 = LINESTRING(0 0,3 4) (type LineString, length 5)"
