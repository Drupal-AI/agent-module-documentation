#!/usr/bin/env bash
# Execution RESET: clear the geophp_eval_area state key so verify FAILS until the agent computes
# and stores the polygon area. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::state()->delete("geophp_eval_area");' >/dev/null 2>&1
echo "reset: state geophp_eval_area cleared"
