#!/usr/bin/env bash
# Execution RESET: clear the second result state key. Doubles as cleanup. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::state()->delete("format_bytes_eval.result2");' >/dev/null 2>&1
echo "reset: state format_bytes_eval.result2 cleared"
