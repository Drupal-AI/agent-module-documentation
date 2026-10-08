#!/usr/bin/env bash
# Introspection CLEANUP: remove the second state key. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::state()->delete("format_bytes_eval.raw2");' >/dev/null 2>&1
echo "cleanup: state format_bytes_eval.raw2 deleted"
