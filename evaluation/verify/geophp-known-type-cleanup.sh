#!/usr/bin/env bash
# Introspection CLEANUP: delete the geophp_eval_input2 state key. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::state()->delete("geophp_eval_input2");' >/dev/null 2>&1
echo "cleanup: state geophp_eval_input2 deleted"
