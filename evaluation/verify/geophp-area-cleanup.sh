#!/usr/bin/env bash
# Execution CLEANUP: delete the geophp_eval_area state key. Idempotent. Exit 0.
# and stores the polygon area. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::state()->delete("geophp_eval_area");' >/dev/null 2>&1
echo "cleanup: state geophp_eval_area deleted"
