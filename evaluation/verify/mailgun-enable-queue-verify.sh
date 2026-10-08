#!/usr/bin/env bash
# Execution VERIFY: PASS when mailgun.settings use_queue === TRUE. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval 'print var_export(\Drupal::config("mailgun.settings")->get("use_queue"), TRUE);' 2>/dev/null)
echo "use_queue=$out"
[ "$out" = "true" ] && exit 0 || exit 1
