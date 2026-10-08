#!/usr/bin/env bash
# Introspection SETUP: store a second known raw byte value (1 GiB) in Drupal State.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::state()->set("format_bytes_eval.raw2", 1073741824);' >/dev/null 2>&1
echo "setup: state format_bytes_eval.raw2 = 1073741824 (format_bytes -> '1 GB')"
