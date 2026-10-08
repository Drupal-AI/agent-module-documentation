#!/usr/bin/env bash
# Execution RESET: clear the result state key so verify FAILS until the agent renders the value
# with the format_bytes filter and stores it. Doubles as cleanup. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::state()->delete("format_bytes_eval.result");' >/dev/null 2>&1
echo "reset: state format_bytes_eval.result cleared"
