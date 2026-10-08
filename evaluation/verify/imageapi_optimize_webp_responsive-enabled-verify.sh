#!/usr/bin/env bash
# Execution VERIFY: PASS when imageapi_optimize_webp_responsive is installed. Exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval 'print (\Drupal::moduleHandler()->moduleExists("imageapi_optimize_webp_responsive") ? "PASS" : "FAIL") . "\n";' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
