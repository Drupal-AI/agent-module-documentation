#!/usr/bin/env bash
# Execution VERIFY: PASS when the htmx_debug module is installed/enabled. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval 'print \Drupal::moduleHandler()->moduleExists("htmx_debug") ? "PASS enabled" : "FAIL disabled";' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
