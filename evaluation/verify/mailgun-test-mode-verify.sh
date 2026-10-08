#!/usr/bin/env bash
# Execution VERIFY: PASS when mailgun.settings test_mode === TRUE. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval 'print var_export(\Drupal::config("mailgun.settings")->get("test_mode"), TRUE);' 2>/dev/null)
echo "test_mode=$out"
[ "$out" = "true" ] && exit 0 || exit 1
