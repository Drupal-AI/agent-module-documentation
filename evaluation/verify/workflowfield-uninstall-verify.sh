#!/usr/bin/env bash
# Execution VERIFY: PASS when the workflowfield module is NOT installed. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval 'print \Drupal::moduleHandler()->moduleExists("workflowfield") ? "FAIL" : "PASS";' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
