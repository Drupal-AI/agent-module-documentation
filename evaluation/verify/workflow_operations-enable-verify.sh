#!/usr/bin/env bash
# Execution VERIFY: PASS when the workflow_operations module is installed/enabled. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval 'print \Drupal::moduleHandler()->moduleExists("workflow_operations") ? "PASS" : "FAIL";' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
