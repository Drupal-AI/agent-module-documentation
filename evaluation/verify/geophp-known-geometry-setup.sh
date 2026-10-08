#!/usr/bin/env bash
# Introspection SETUP: store a known WKT polygon in Drupal state (geophp_eval_input) so an agent
# can read it back and use the geophp.geophp service to analyse it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::state()->set("geophp_eval_input", "POLYGON((0 0,0 20,20 20,20 0,0 0))");' >/dev/null 2>&1
echo "setup: state geophp_eval_input = POLYGON((0 0,0 20,20 20,20 0,0 0)) (area 400)"
